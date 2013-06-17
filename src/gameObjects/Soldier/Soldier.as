/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 5/29/13
 * Time: 7:02 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Soldier
{
import gameObjects.*;
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.HouseBase;

import models.GameConfiguration.Soldier.GameConfigurationSoldierDamage;
import models.GameInfo.GameInfo;
import models.Pathfinder.INode;

public class Soldier implements IDisposable
{
    private var _type:EHouseOwner;

    private var _houseOwner:HouseBase;
    private var _houseTarget:HouseBase;

    private var _view:SoldierView;

    private var _path:Array;

    /*
     * Properties
     */
    public function get type():EHouseOwner
    {
        return _type;
    }

    public function get houseOwner():HouseBase
    {
        return _houseOwner;
    }

    public function get houseTarget():HouseBase
    {
        return _houseTarget;
    }

    public function get soldierView():SoldierView
    {
        return _view;
    }

    public function get damage():int
    {
        return GameConfigurationSoldierDamage.getNormalSoldierDamage(_type);
    }

    //! Returns speed value in cells.
    public function get speed():int
    {
        return 3;
    }

    public function get path():Array
    {
        return _path;
    }

    public function get currentPosition():INode
    {
        return _path[0];
    }


    /*
     * Methods
     */

    //! Default constructor
    public function Soldier(owner:HouseBase, target:HouseBase)
    {
        Debug.assert(owner != null);
        Debug.assert(target != null);
        Debug.assert(target != owner);

        _houseOwner = owner;
        _type = _houseOwner.ownerType;
        _houseTarget = target;

        _path = GameInfo.Instance.pathfinder.getPath(_houseOwner.houseExitPosition, _houseTarget.houseExitPosition);

        Debug.assert(_path.length > 0);

        _view = new SoldierView(this);
    }


    /*
     *  IDisposable
     */

    public function cleanup():void
    {
        for each(var node:INode in _path)
        {
            node.cleanup();
            node = null;
        }

        _path = [];

        _view.cleanup();
        _view = null;
    }
}
}
