/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/14/13
 * Time: 10:20 AM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Tower {
import fl.transitions.Tween;
import fl.transitions.TweenEvent;
import fl.transitions.easing.None;

import flash.display.Sprite;
import flash.events.Event;

import gameObjects.House.EHouseType;
import gameObjects.House.House;
import gameObjects.House.HouseView;
import gameObjects.Soldier.Soldier;

import models.ResourceManager.ResourceManager;

import scenes.AquaWars;

public class Tower extends House{

    private var _soldierToShut: Soldier;
    private var _tweenShutMoveX: Tween;
    private var _tweenShutMoveY: Tween;
    private var _bullet: Sprite;

    public function Tower(type:EHouseType, soldiersCount:int) {
        super (type, soldiersCount)
    }



    public function shutOnSoldier(soldier: Soldier):void
    {
        _soldierToShut = soldier;
        var bulletClass: Class = ResourceManager.getBulletClassByOwner(this);
        _bullet = new bulletClass();
        _bullet.x = view.x;
        _bullet.y = view.y - view.height;
        AquaWars.scene.addChild(_bullet);
        _tweenShutMoveX = new Tween(_bullet, 'x', None.easeNone, _bullet.x, soldier.soldierView.x, 0.2, true);
        _tweenShutMoveY = new Tween(_bullet, 'y', None.easeNone, _bullet.y, soldier.soldierView.y, 0.2, true);
        _tweenShutMoveX.addEventListener(TweenEvent.MOTION_FINISH, didShutFinish);
    }

    private function didShutFinish(e: Event):void
    {
        AquaWars.scene.removeChild(_bullet);
        _bullet = null;

        if (_soldierToShut.soldierView != null)
        {
            _soldierToShut.soldierView.removeTweenEventListener();
            _soldierToShut.cleanup();
        }
        _tweenShutMoveX.removeEventListener(TweenEvent.MOTION_FINISH, didShutFinish);
    }
}
}
