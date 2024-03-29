/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/6/13
 * Time: 11:43 PM
 * To change this template use File | Settings | File Templates.
 */
package models.GameInfo
{
import models.Game.GameBase;
import models.HouseManager.HouseManager;
import models.Pathfinder.Pathfinder;
import models.SoldierGenerator.SoldierGenerator;

import scenes.AquaWars;

public class GameInfo
{

    /*
     * Singleton realization
     */

    private static const _instance:GameInfo = new GameInfo();

    //! Default constructor
    public function GameInfo()
    {
        if (_instance)
        {
            throw new Error("Class is singleton.");
        }

        init();
    }

    public static function get Instance():GameInfo
    {
        return _instance;
    }

    /*
     * Fields
     */

    private var _pathfinder:Pathfinder;
    private var _soldierGenerator:SoldierGenerator;
    private var _houseManager:HouseManager;
    private var _currentGame:GameBase;

    /*
     * Properties
     */


    public function get pathfinder():Pathfinder
    {
        return _pathfinder;
    }

    public function get soldierGenerator():SoldierGenerator
    {
        return _soldierGenerator;
    }

    public function get houseManager():HouseManager
    {
        return _houseManager;
    }


    public function setCurrentGame(value:GameBase):void
    {
        Debug.assert(value != null);
        _currentGame = value;
    }

    public function get currentGame():GameBase
    {
        return _currentGame;
    }

    /*
     * Methods
     */

    private function init():void
    {
        _pathfinder = new Pathfinder();
        _soldierGenerator = new SoldierGenerator();
        _houseManager = new HouseManager();
    }

}
}
