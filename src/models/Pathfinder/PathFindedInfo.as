/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/6/13
 * Time: 1:44 AM
 * To change this template use File | Settings | File Templates.
 */
package models.Pathfinder
{
public class PathFindedInfo
{
    /*
     * Fields
     */
    private var _from:INode;
    private var _to:INode;

    private var _path:Array;

    /*
     * Properties
     */

    public function  get nodeFrom():INode
    {
        return _from;
    }

    public function  get nodeTo():INode
    {
        return _to;
    }

    public function  get nodePathClone():Array
    {
        var result:Array = [];

        for each(var node:INode in _path)
        {
            result.push(node);
        }

        //TODO: implement random
        return result;
    }

    /*
     * Methods
     */
    //! Default initializer
    //TODO: change path to paths
    public function PathFindedInfo(from:INode, to:INode, path:Array)
    {
        GameUtils.assert(from != null);
        GameUtils.assert(to != null);
        GameUtils.assert(path != null);

        _from = from;
        _to = to;

        _path = path;

    }
}
}
