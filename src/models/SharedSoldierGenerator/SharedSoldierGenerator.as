/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 5/31/13
 * Time: 11:39 AM
 * To change this template use File | Settings | File Templates.
 */

package models.SharedSoldierGenerator
{
import flash.events.TimerEvent;
import flash.utils.Timer;

import gameObjects.House.House;
import gameObjects.Soldier.ESoldierRotation;
import gameObjects.Soldier.Soldier;
import gameObjects.Soldier.SoldierView;

import fl.transitions.Tween;
import fl.transitions.TweenEvent;
import fl.transitions.easing.None;

import flash.events.Event;

import models.SharedPathfinder.INode;
import models.SharedPathfinder.Node;

import models.SharedPathfinder.SharedPathfinder;

import scenes.AquaWars;

public class SharedSoldierGenerator
{
    /*
     * Singleton realization
     */

    private static const _instance:SharedSoldierGenerator = new SharedSoldierGenerator();

    //Переменная доступа
    private static var _isConstructing:Boolean;

    //! Default constructor
    public function SharedSoldierGenerator()
    {
        if (_instance)
        {
            throw new Error("Class is singleton.");
        }

        init();
    }

    public static function get Instance():SharedSoldierGenerator
    {
        return _instance;
    }

    /*
     * Fields
     */

    private var _timerSoldierGenerator:Timer;

    private var _soldierWaves:Array;

    /*
     * Methods
     */

    private function init():void
    {
        _soldierWaves = [];

        _timerSoldierGenerator = new Timer(1000);
        _timerSoldierGenerator.addEventListener(TimerEvent.TIMER, processWave);
        _timerSoldierGenerator.start();
    }

    public function generateSoldiers(owner:House, target:House):void
    {
        GameUtils.assert(owner != null);
        GameUtils.assert(target != null);

        var newWave:SoldierWaveInfo = new SoldierWaveInfo();

        newWave.generatedSoldierMax = 10; //TODO: make configurable
        newWave.owner = owner;
        newWave.target = target;

        _soldierWaves.push(newWave);
    }

    private function processWave(e:Event):void
    {
        for each(var _waveInfo:SoldierWaveInfo in _soldierWaves)
        {
            if (_waveInfo.generatedSoldierMax == 0)
            {
                //TODO: remove from array
                continue;
            }

            //TODO: add last generated time  and change timer from 1000 to 250

            var newSoldier:Soldier = new Soldier(_waveInfo.owner, _waveInfo.target);

            newSoldier.soldierView.x = newSoldier.currentPosition.view.x + Math.round(newSoldier.soldierView.width / 2) - Node.NodeWidthHalf;
            newSoldier.soldierView.y = newSoldier.currentPosition.view.y;

            AquaWars.scene.addChild(newSoldier.soldierView);

            moveSoldierToNextNode(newSoldier);

            _waveInfo.generatedSoldierMax--;
        }
    }

    private function moveSoldierToNextNode(soldier:Soldier):void
    {
        var nodeFrom:INode = soldier.currentPosition;
        var nodeTo:INode = soldier.path[1];

        soldier.soldierView.soldierRotation = getSoldierRotation(nodeFrom, nodeTo);

        var tweenX:Tween = new Tween(soldier.soldierView, "x", None.easeNone, nodeFrom.view.x, nodeTo.view.x, 1 / soldier.speed, true);
        var tweenY:Tween = new Tween(soldier.soldierView, "y", None.easeNone, nodeFrom.view.y, nodeTo.view.y, 1 / soldier.speed, true);

        //TODO: review event
        tweenX.addEventListener(TweenEvent.MOTION_FINISH, didMovementFinish);
    }

    private function didMovementFinish(e:Event):void
    {
        var target:Tween = e.target as Tween;
        target.removeEventListener(TweenEvent.MOTION_FINISH, didMovementFinish);

        var soldierView:SoldierView = e.target.obj as SoldierView;

        var soldierPath:Array = soldierView.owner.path;

        //TODO:remove first another way
        {   //remove first node
            soldierPath.reverse();
            soldierPath.pop();
            soldierPath.reverse();
        }

        if (soldierPath[soldierPath.length - 1] == soldierPath[0])
        {
            soldierView.owner.houseTarget.didAttack(soldierView.owner);

            soldierView.owner.cleanup()
        }
        else
        {
            moveSoldierToNextNode(soldierView.owner);
        }
    }

    private static function getSoldierRotation(from:INode, to:INode):ESoldierRotation
    {
        GameUtils.assert(from != null);
        GameUtils.assert(to != null);
        GameUtils.assert(from.row != to.row || from.column != to.column);

        var result:ESoldierRotation;

        if (from.row > to.row)
        {
            if (from.column == to.column)
            {
                result = ESoldierRotation.ESR_DOWN;
            }
            else if (from.column < to.column)
            {
                result = ESoldierRotation.ESR_DOWN_RIGHT;
            }
            else
            {
                result = ESoldierRotation.ESR_DOWN_LEFT;
            }
        }
        else if (from.row < to.row)
        {
            if (from.column == to.column)
            {
                result = ESoldierRotation.ESR_UP;
            }
            else if (from.column < to.column)
            {
                result = ESoldierRotation.ESR_UP_RIGHT;
            }
            else
            {
                result = ESoldierRotation.ESR_UP_LEFT;
            }
        }
        else
        {
            if (from.column > to.column)
            {
                result = ESoldierRotation.ESR_LEFT;
            }
            else
            {
                result = ESoldierRotation.ESR_RIGHT;
            }
        }

        return result;
    }
}
}
