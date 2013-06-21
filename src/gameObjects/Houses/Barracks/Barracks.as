/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/29/13
 * Time: 4:17 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Houses.Barracks
{
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.EHouseType;
import gameObjects.Houses.Base.HouseBase;

//! Represents model of Barracks
public class Barracks extends HouseBase
{

    private var _timerSoldierGenerator:Timer;


    /*
     * Properties
     */

    public override function get type():EHouseType
    {
        return EHouseType.EHT_BARRACKS;
    }

    /*
     * Methods
     */

    //! Default constructor for barracks
    //! If owner type == null -> type = neutral
    public function Barracks(soldiersCount:int, ownerType:EHouseOwner = null)
    {
        super(soldiersCount, ownerType);

        //TODO: move to config
        _timerSoldierGenerator = new Timer(1000);
        _timerSoldierGenerator.addEventListener(TimerEvent.TIMER, incrementSoldierCount);
        _timerSoldierGenerator.start();
    }

    private function incrementSoldierCount(e:Event):void
    {
        if (_ownerType != EHouseOwner.EHO_NEUTRAL)
        {
            if (_soldierCount < _soldierCountMax)
            {
                setSoldierCount(_soldierCount + 1);
            }
            else if (_soldierCount >= _soldierCountMax + 1)
            {
                setSoldierCount(_soldierCount - 1);
            }
        }
    }


    public function stopSoldierGenerator():void
    {
        _timerSoldierGenerator.stop();
    }

    public function playSoldierGenerator():void
    {
        _timerSoldierGenerator.start();
    }


    /*
     * IDisposable
     */

    public override function cleanup():void
    {
        _timerSoldierGenerator.stop();
        _timerSoldierGenerator = null;
        super.cleanup();
    }
}
}
