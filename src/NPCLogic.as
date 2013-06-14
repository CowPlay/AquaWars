/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/10/13
 * Time: 2:30 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import gameObjects.House.EHouseType;
import gameObjects.House.House;
import gameObjects.Soldier.Soldier;
import gameObjects.Tower.Tower;

import models.GameInfo.GameInfo;
import models.SoldierGenerator.SoldierGenerator;

public class NPCLogic {

    private var _timerWatchSituation: Timer;


    public function NPCLogic() {
        init();
    }

    private function init():void
    {
       _timerWatchSituation = new Timer(500);
       _timerWatchSituation.addEventListener(TimerEvent.TIMER, watchSituation);
       _timerWatchSituation.start();

        var towerShutTimer: Timer = new Timer(500);
        towerShutTimer.addEventListener(TimerEvent.TIMER, findShutSoldierTarget);
        towerShutTimer.start();

    }

    private function watchSituation(e: Event):void
    {
        for each(var house: House in GameInfo.Instance.houseManager.houses)
        {
            if (house.type == EHouseType.EHT_PLAYER
                    && house.soldierCount <= Math.floor(house.soldierCountMax/2))
            {
                var nearestEnemyHouse: House = NearestHouseFinder.findNearestHouse(house, GameInfo.Instance.houseManager.houses);
                if (nearestEnemyHouse != null)
                {
                    GameInfo.Instance.soldierGenerator.generateSoldiers(nearestEnemyHouse, house);
                }

            }
        }
    }


    private function findShutSoldierTarget(e: Event):void
    {
         for each(var soldier: Soldier in GameInfo.Instance.soldierGenerator.soldierList)
         {
             for each(var tower: Tower in GameInfo.Instance.houseManager.towers)
             {
                 if (tower is Tower)
                 {
                     if (soldier.soldierView == null)
                     {
                         var soldierIndex: int = GameInfo.Instance.soldierGenerator.soldierList.indexOf(soldier);
                         GameInfo.Instance.soldierGenerator.soldierList.splice(soldierIndex, 1);
                         trace("exist null soldier");
                         continue;
                     }
                     if (soldier.type != tower.type)
                     {
                         var a: Number = Math.abs(soldier.soldierView.x - tower.view.x);
                         var b: Number = Math.abs(soldier.soldierView.y - tower.view.y);
                         var distance: Number = Math.sqrt(a*a + b*b);
                         if (distance <= 120)
                         {
                             tower.shutOnSoldier(soldier);
                             soldierIndex = GameInfo.Instance.soldierGenerator.soldierList.indexOf(soldier);
                             GameInfo.Instance.soldierGenerator.soldierList.splice(soldierIndex, 1);
                             return;
                         }
                     }
                 }
             }
         }
    }

}
}
