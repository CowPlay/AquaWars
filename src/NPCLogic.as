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

import models.GameInfo.GameInfo;

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
    }

    private function watchSituation(e: Event):void
    {
        for each(var house: House in GameInfo.Instance.houseManager.houses)
        {
            if (house.type == EHouseType.EHT_PLAYER
                    && house.soldierCount <= Math.floor(house.soldierCountMax/2))
            {
                var nearestEnemyHouse = NearestHouseFinder.findNearestHouse(house, GameInfo.Instance.houseManager.houses);
                if (nearestEnemyHouse != null)
                {
                    GameInfo.Instance.soldierGenerator.generateSoldiers(nearestEnemyHouse, house);
                }

            }
        }
    }

}
}
