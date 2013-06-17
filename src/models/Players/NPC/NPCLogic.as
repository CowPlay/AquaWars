/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/10/13
 * Time: 2:30 PM
 * To change this template use File | Settings | File Templates.
 */
package models.Players.NPC
{
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import gameObjects.Houses.Barracks.Barracks;
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.HouseBase;
import gameObjects.Houses.Tower.Tower;
import gameObjects.Soldier.Soldier;

import models.GameInfo.GameInfo;
import models.Players.Player;

public class NPCLogic extends Player
{

    /*
     * Fields
     */
    private var _timerWatchSituation:Timer;


    /*
     * Methods
     */

    //! Default constructor
    public function NPCLogic()
    {
        init();
    }

    private function init():void
    {
        //TODO: implement
//        _timerWatchSituation = new Timer(500);
//        _timerWatchSituation.addEventListener(TimerEvent.TIMER, simulatePlayerLogic);
//        _timerWatchSituation.start();

        //TODO: implement
//        var towerShutTimer:Timer = new Timer(500);
//        towerShutTimer.addEventListener(TimerEvent.TIMER, findShutSoldierTarget);
//        towerShutTimer.start();

    }

    protected function simulatePlayerLogic(e:Event):void
    {
        for each(var house:HouseBase in GameInfo.Instance.houseManager.houses)
        {
            if (house.ownerType == EHouseOwner.EHO_PLAYER
                    && house.soldierCount <= Math.floor(house.soldierCountMax / 2))
            {

                var nearestEnemyHouse:HouseBase = GameInfo.Instance.pathfinder.getNearestHouse(house, EHouseOwner.EHO_ENEMY);

                if (nearestEnemyHouse != null)
                {
                    GameInfo.Instance.soldierGenerator.generateSoldiers(nearestEnemyHouse, house);
                }

            }
        }
    }


    //TODO: implement
//    private function findShutSoldierTarget(e:Event):void
//    {
//        for each(var soldier:Soldier in GameInfo.Instance.soldierGenerator.soldierList)
//        {
//            for each(var tower:Tower in GameInfo.Instance.houseManager.towers)
//            {
//                if (tower is Tower)
//                {
//                    if (soldier.soldierView == null)
//                    {
//                        var soldierIndex:int = GameInfo.Instance.soldierGenerator.soldierList.indexOf(soldier);
//                        GameInfo.Instance.soldierGenerator.soldierList.splice(soldierIndex, 1);
//                        trace("exist null soldier");
//                        continue;
//                    }
//                    if (soldier.type != tower.ownerType)
//                    {
//                        var a:Number = Math.abs(soldier.soldierView.x - tower.view.x);
//                        var b:Number = Math.abs(soldier.soldierView.y - tower.view.y);
//                        var distance:Number = Math.sqrt(a * a + b * b);
//                        if (distance <= 120)
//                        {
//                            tower.shutOnSoldier(soldier);
//                            soldierIndex = GameInfo.Instance.soldierGenerator.soldierList.indexOf(soldier);
//                            GameInfo.Instance.soldierGenerator.soldierList.splice(soldierIndex, 1);
//                            return;
//                        }
//                    }
//                }
//            }
//        }
//    }

    /*
     *  IDisposable
     */

    public override function cleanup():void
    {
        _timerWatchSituation.stop();
        _timerWatchSituation = null;

        super.cleanup();
    }

}
}
