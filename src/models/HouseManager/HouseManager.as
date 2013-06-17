/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/7/13
 * Time: 12:31 AM
 * To change this template use File | Settings | File Templates.
 */
package models.HouseManager
{
import gameObjects.House.EHouseType;
import gameObjects.House.House;

import scenes.AquaWars;

public class HouseManager
{
    /*
     * Fields
     */
    private var _houses:Array;

    /*
     * Properties
     */

    public function get houses():Array
    {
        return _houses;
    }

    /*
     * Methods
     */

    //! Default constructor
    public function HouseManager()
    {
        _houses = [];

        init();
    }

    private function init():void
    {
    }

    public function initLevelHouses():void
    {
        {//house 1
            var _house1:House = House.HouseWithType(EHouseType.EHT_PLAYER, 10);

            _house1.setPosition(15, 3);

            _houses.push(_house1);
        }

        {//house 3
            var _house2:House = House.HouseWithType(EHouseType.EHT_PLAYER, 9);

            _house2.setPosition(3, 15);

            _houses.push(_house2);
        }

        {//house 2
            var _house3:House = House.HouseWithType(EHouseType.EHT_PLAYER, 9);

            _house3.setPosition(42, 42);

            _houses.push(_house3);
        }

        {//house 4
            var _house4:House = House.HouseWithType(EHouseType.EHT_PLAYER, 9);

            _house4.setPosition(40, 10);

            AquaWars.scene.addChild(_house4.view);

            _houses.push(_house4);
       }

        {//house 5
            var _house5:House = House.HouseWithType(EHouseType.EHT_PLAYER, 9);

            _house5.setPosition(10, 40);

            AquaWars.scene.addChild(_house5.view);

            _houses.push(_house5);
        }

        {//house 6
            var _house6:House = House.HouseWithType(EHouseType.EHT_PLAYER, 9);

            _house6.setPosition(20, 20);

            AquaWars.scene.addChild(_house6.view);

            _houses.push(_house6);
        }

    }
}
}
