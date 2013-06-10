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
import gameObjects.House.House;

import models.GameInfo.GameInfo;

import models.Pathfinder.INode;
import models.Pathfinder.Pathfinder;

public class Soldier implements IDisposable
{
    private var _houseOwner:House;
    private var _houseTarget:House;

    private var _view:SoldierView;

    private var _path:Array;

    /*
     * Properties
     */

    public function get houseOwner():House
    {
        return _houseOwner;
    }

    public function get houseTarget():House
    {
        return _houseTarget;
    }

    public function get soldierView():SoldierView
    {
        return _view;
    }

    public function get damage():int
    {
        return 1;
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
    public function Soldier(owner:House, target:House)
    {
        GameUtils.assert(owner != null);
        GameUtils.assert(target != null);
        GameUtils.assert(target != owner);

        _houseOwner = owner;
        _houseTarget = target;

        _path = GameInfo.Instance.pathfinder.getPath(_houseOwner.houseExitPosition, _houseTarget.houseExitPosition);

        GameUtils.assert(_path.length > 0);

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
