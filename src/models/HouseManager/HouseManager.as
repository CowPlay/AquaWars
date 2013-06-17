/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/7/13
 * Time: 12:31 AM
 * To change this template use File | Settings | File Templates.
 */
package models.HouseManager
{
import gameObjects.Houses.Barracks.Barracks;
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Smithy.Smithy;
import gameObjects.Houses.Stable.Stable;
import gameObjects.Houses.Tower.Tower;

import scenes.AquaWars;

public class HouseManager
{
    /*
     * Fields
     */
    private var _houses:Array;

    private var _towers:Array;

    /*
     * Properties
     */

    public function get houses():Array
    {
        return _houses;
    }


    public function get towers():Array
    {
        return _towers;
    }

    /*
     * Methods
     */

    //! Default constructor
    public function HouseManager()
    {
        _houses = [];

        _towers = [];

        init();
    }

    private function init():void
    {
    }

    public function initLevelHouses():void
    {
        {//house 1
            var _house1:Barracks = new Barracks(10, EHouseOwner.EHO_PLAYER);

            _house1.setPosition(20, 0);

            _houses.push(_house1);
        }

        {//house 2
            var _house2:Barracks = new Barracks(9, EHouseOwner.EHO_PLAYER);

            _house2.setPosition(0, 20);

            _houses.push(_house2);
        }

        {//house 3
            var _house3:Tower = new Tower(10);

            _house3.setPosition(20, 20);

            _houses.push(_house3);

            _towers.push(_house3);
        }

        {//house 4
            var _house4:Barracks = new Barracks(9, EHouseOwner.EHO_ENEMY);

            _house4.setPosition(40, 20);

            AquaWars.scene.addChild(_house4.view);

            _houses.push(_house4);
        }

        {//house 5
            var _house5:Barracks = new Barracks(9, EHouseOwner.EHO_ENEMY);

            _house5.setPosition(20, 40);

            AquaWars.scene.addChild(_house5.view);

            _houses.push(_house5);
        }


        {//forge 6
            var forge:Smithy = new Smithy(9);

            forge.setPosition(0, 40);

            AquaWars.scene.addChild(forge.view);

            _houses.push(forge);


        }

        {//stable 1
            var stable:Stable = new Stable(9);

            stable.setPosition(40, 0);

            AquaWars.scene.addChild(stable.view);

            _houses.push(stable);
        }

    }
}
}
