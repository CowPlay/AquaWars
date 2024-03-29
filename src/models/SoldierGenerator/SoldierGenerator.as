/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 5/31/13
 * Time: 11:39 AM
 * To change this template use File | Settings | File Templates.
 */

package models.SoldierGenerator
{
import fl.transitions.Tween;
import fl.transitions.TweenEvent;
import fl.transitions.easing.None;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import gameObjects.Houses.Base.HouseBase;
import gameObjects.Houses.Stable.Stable;
import gameObjects.IDisposable;
import gameObjects.Soldier.ESoldierRotation;
import gameObjects.Soldier.Soldier;
import gameObjects.Soldier.SoldierView;

import models.Pathfinder.INode;
import models.Pathfinder.Node;

import scenes.AquaWars;

public class SoldierGenerator implements IDisposable
{
    /*
     * Fields
     */

    private var _timerSoldierGenerator:Timer;

    private var _soldierWaves:Array;

    private var _soldierList: Array;

    /*
     * Properties
     */
     public function get soldierList():Array
     {
         return _soldierList;
     }

    /*
     * Methods
     */


    //! Default constructor
    public function SoldierGenerator()
    {
        init();
    }

    private function init():void
    {
        _soldierWaves = [];

        _soldierList = [];

        _timerSoldierGenerator = new Timer(250);
        _timerSoldierGenerator.addEventListener(TimerEvent.TIMER, processWave);
        _timerSoldierGenerator.start();
    }

    public function generateSoldiers(owner:HouseBase, target:HouseBase):void
    {
        Debug.assert(owner != null);
        Debug.assert(target != null);

        var newWave:SoldierWaveInfo = new SoldierWaveInfo();

        newWave.generatedSoldierRest = 10; //TODO: make configurable
        newWave.owner = owner;
        newWave.target = target;
        newWave.timeGeneratedFrequency = 300;
        newWave.generatedSoldierCount = 1;

        _soldierWaves.push(newWave);
    }

    private function processWave(e:Event):void
    {
        var wavesForRemove:Array = [];

        for each(var waveInfo:SoldierWaveInfo in _soldierWaves)
        {
            if (waveInfo.generatedSoldierRest == 0)
            {
                wavesForRemove.push(waveInfo);
                continue;
            }

            var currentTime:Number = new Date().time;

            var isFirstProcess:Boolean = waveInfo.timeGeneratedLast == 0;
            var isTimeForGenerate:Boolean = currentTime - waveInfo.timeGeneratedLast > waveInfo.timeGeneratedFrequency;

            if (!isFirstProcess && !isTimeForGenerate)
            {
                continue;
            }

            waveInfo.timeGeneratedLast = currentTime;

          for (var i:int = 0; i < waveInfo.generatedSoldierCount; i++)
          {
              if(waveInfo.owner.soldierCount < 2)
              {
                  wavesForRemove.push(waveInfo);
                  break;
              }

              generateSoldier(waveInfo);
              waveInfo.generatedSoldierRest--;
          }
        }


        //remove waves which done
        for each(var waveInfoRemove:SoldierWaveInfo in wavesForRemove)
        {
            var waveIndex:int = _soldierWaves.indexOf(waveInfoRemove);
            _soldierWaves.splice(waveIndex, 1);
        }
    }

    private function generateSoldier(waveInfo:SoldierWaveInfo):void
    {
        var newSoldier:Soldier = new Soldier(waveInfo.owner, waveInfo.target);

        _soldierList.unshift(newSoldier);

        newSoldier.soldierView.x = newSoldier.currentPosition.view.x + Math.round(newSoldier.soldierView.width / 2) - Node.NodeWidthHalf;
        newSoldier.soldierView.y = newSoldier.currentPosition.view.y;

        AquaWars.scene.addChild(newSoldier.soldierView);
        waveInfo.owner.didSoldierLeaveHouse();

        moveSoldierToNextNode(newSoldier);
    }

    private function moveSoldierToNextNode(soldier:Soldier):void
    {
        var nodeFrom:INode = soldier.currentPosition;
        var nodeTo:INode = soldier.path[1];

        soldier.soldierView.soldierRotation = getSoldierRotation(nodeFrom, nodeTo);

        //TODO move to soldier param ond define by class type house
        if(soldier.houseOwner is Stable)
        {
            var soldierSpeed: Number = 1 / soldier.speed/2;
        }
        else
        {
            soldierSpeed = 1 / soldier.speed;
        }


        var tweenX:Tween = new Tween(soldier.soldierView, "x", None.easeNone, nodeFrom.view.x, nodeTo.view.x,soldierSpeed , true);
        var tweenY:Tween = new Tween(soldier.soldierView, "y", None.easeNone, nodeFrom.view.y, nodeTo.view.y, soldierSpeed, true);

        soldier.soldierView.setTransportableTweens(tweenX, tweenY);
        soldier.soldierView.setTweenListenerFunction(didMovementFinish);

        tweenX.addEventListener(TweenEvent.MOTION_FINISH, didMovementFinish);
    }

    private function didMovementFinish(e:Event):void
    {
        var target:Tween = e.target as Tween;
        target.removeEventListener(TweenEvent.MOTION_FINISH, didMovementFinish);
        var soldierView:SoldierView = e.target.obj as SoldierView;

        var soldierPath:Array = soldierView.owner.path;

        //remove first node
        soldierPath.splice(0, 1);

        if (soldierPath[soldierPath.length - 1] == soldierPath[0])
        {
            soldierView.owner.houseTarget.didSoldierComeHouse(soldierView.owner);

            soldierView.owner.cleanup();

            var soldierIndex: int = _soldierList.indexOf(soldierView.owner);
            _soldierList.splice(soldierIndex, 1)
        }
        else
        {
            moveSoldierToNextNode(soldierView.owner);
        }
    }

    private static function getSoldierRotation(from:INode, to:INode):ESoldierRotation
    {
        Debug.assert(from != null);
        Debug.assert(to != null);
        Debug.assert(from.row != to.row || from.column != to.column);

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

    //!Pause
    public function stopSoldiersMove():void
    {
        _timerSoldierGenerator.stop();
        for each(var soldier:Soldier in _soldierList)
        {
            soldier.soldierView.soldierMoveStop();
        }
    }

    public function playSoldiersMove():void
    {
        _timerSoldierGenerator.start();
        for each(var soldier:Soldier in _soldierList)
        {
            soldier.soldierView.soldierMovePlay();
        }
    }

    /*
     * IDisposable
     */

    public function cleanup():void
    {
        _timerSoldierGenerator.stop();
        _timerSoldierGenerator = null;

        //TODO: cleanup _soldierWaves and _soldierList
    }
}
}
