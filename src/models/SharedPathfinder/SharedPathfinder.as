package models.SharedPathfinder
{
import flash.utils.Dictionary;

import org.osmf.net.StreamingURLResource;


//! Class which contains info about level grid and provide find path functionally
public class SharedPathfinder
{
    /*
     * Singleton realization
     */

    private static const _instance:SharedPathfinder = new SharedPathfinder();

    //! Default constructor
    public function SharedPathfinder()
    {
        if (_instance)
        {
            throw new Error("Class is singleton.");
        }

        Init();
    }

    public static function get Instance():SharedPathfinder
    {
        return _instance;
    }

    /*
     * Static methods
     */

    private static function getPathHash(nodeFrom:INode, nodeTo:INode):String
    {
        return  nodeFrom.toString() + ":" + nodeTo.toString();
    }

    private static function BuildPath(destinationNode:INode, startNode:INode):Array
    {
        var result:Array = [];

        var node:INode = destinationNode;

        result.push(node);

        while (node != startNode)
        {
            node = node.parentNode;
            result.unshift(node);
        }

        return result;
    }

    private static function isOpen(node:INode, openNodes:Array):Boolean
    {
        var result:Boolean = false;

        for (var i:int = 0; i < openNodes.length; ++i)
        {
            if (openNodes[i] == node)
            {
                result = true;
                break;
            }
        }

        return result;
    }

    private static function isClosed(node:INode, closedNodes:Array):Boolean
    {
        var result:Boolean = false;

        for (var i:int = 0; i < closedNodes.length; ++i)
        {
            if (closedNodes[i] == node)
            {
                result = true;
                break;
            }
        }

        return result;
    }

    /*
     * Fields
     */

    private static const GRID_COLUMN_COUNT:int = 50;
    private static const GRID_ROW_COUNT:int = 50;

    //! Array of (array of nodes)
    private var _grid:Array;

    private var _pathsCache:Dictionary;

    /*
     * Properties
     */

    public function get grid():Array
    {
        return _grid;
    }


    /*
     * Methods
     */

    private function Init():void
    {
        _pathsCache = new Dictionary();

        { // Create grid
            _grid = [];

            for (var row:int = 0; row < GRID_ROW_COUNT; row++)
            {
                var newRow:Array = [];

                for (var column:int = 0; column < GRID_COLUMN_COUNT; column++)
                {
                    var newNode:INode = new Node(row, column);

                    newRow.push(newNode);
                }

                _grid.push(newRow);
            }
        }
    }

    public function FindPath(nodeFrom:INode, nodeTo:INode):Array
    {
        var result:Array;

        var findedParhInfo:PathFindedInfo = tryGetPathFromCache(nodeFrom, nodeTo);

        if (findedParhInfo != null)
        {
            return  findedParhInfo.nodePathClone;
        }

        var openNodes:Array = [];
        var closedNodes:Array = [];

        var currentNode:INode = nodeFrom;
        var testNode:INode;

        var l:int;
        var i:int;

        var connectedNodes:Array;
        var travelCost:Number = 1.0;

        var g:Number;
        var h:Number;
        var f:Number;

        currentNode.g = 0;
        currentNode.h = euclidianHeuristic(currentNode, nodeTo, travelCost);
        currentNode.f = currentNode.g + currentNode.h;

        while (currentNode != nodeTo)
        {
            connectedNodes = FindConnectedNodes(currentNode);

            for (i = 0; i < connectedNodes.length; ++i)
            {
                testNode = connectedNodes[i];

                if (testNode == currentNode || testNode.traversable == false)
                {
                    continue;
                }

                //For our example we will test just highlight all the tested nodes
                Node(testNode).highlight(0xFF80C0);

                //g = currentNode.g + Pathfinder.heuristic( currentNode, testNode, travelCost); //This is what we had to use here at Untold for our situation.
                //If you have a world where diagonal movements cost more than regular movements then you would need to determine if a movement is diagonal and then adjust
                //the value of travel cost accordingly here.
                g = currentNode.g + travelCost;
                h = euclidianHeuristic(testNode, nodeTo, travelCost);
                f = g + h;

                if (isOpen(testNode, openNodes) || isClosed(testNode, closedNodes))
                {
                    if (testNode.f > f)
                    {
                        testNode.f = f;
                        testNode.g = g;
                        testNode.h = h;
                        testNode.parentNode = currentNode;
                    }
                }
                else
                {
                    testNode.f = f;
                    testNode.g = g;
                    testNode.h = h;
                    testNode.parentNode = currentNode;
                    openNodes.push(testNode);
                }

            }
            closedNodes.push(currentNode);

            if (openNodes.length == 0)
            {
                return null;
            }

            openNodes.sortOn('f', Array.NUMERIC);
            currentNode = openNodes.shift() as INode;
        }

        var newPath:Array = BuildPath(nodeTo, nodeFrom);

        {//add to cache
            var pathHash:String = getPathHash(nodeFrom, nodeTo);

            findedParhInfo = new PathFindedInfo(nodeFrom, nodeTo, newPath);

            _pathsCache[pathHash] = findedParhInfo;

            result = findedParhInfo.nodePathClone;
        }


        return result;
    }

//! Return path from cache if exist. Otherwise returns null.
    private function tryGetPathFromCache(nodeFrom:INode, nodeTo:INode):PathFindedInfo
    {
        var result:PathFindedInfo;

        var pathHash:String = getPathHash(nodeFrom, nodeTo);

        result = _pathsCache[pathHash];

        //try reverse path
        if (result == null)
        {
            pathHash = getPathHash(nodeTo, nodeFrom);

            result = _pathsCache[pathHash];
        }

        return result;
    }


    private function FindConnectedNodes(node:INode):Array
    {
        var result:Array = [];

        var rowMin:int = node.row > 0 ? node.row - 1 : 0;
        var rowMax:int = node.row < GRID_ROW_COUNT - 1 ? node.row + 1 : GRID_ROW_COUNT - 1;

        var columnMin:int = node.column > 0 ? node.column - 1 : node.column;
        var columnMax:int = node.column < GRID_COLUMN_COUNT - 1 ? node.column + 1 : GRID_COLUMN_COUNT - 1;


        for (var currentRow:int = rowMin; currentRow <= rowMax; currentRow++)
        {
            var row:Array = _grid[currentRow];

            for (var column:int = columnMin; column <= columnMax; column++)
            {
                var connectedNode:INode = row[column];

                //TODO: add if(connected == node) continue;
                /*if (connectedNode == node)
                 {
                 continue;
                 } */

                result.push(connectedNode);
            }
        }

        return result;
    }


    /******************************************************************************
     *
     *    These are our available heuristics
     *
     ******************************************************************************/
    private function euclidianHeuristic(node:INode, destinationNode:INode, cost:Number = 1.0):Number
    {
        var dx:Number = node.column - destinationNode.column;
        var dy:Number = node.row - destinationNode.row;

        return Math.sqrt(dx * dx + dy * dy) * cost;
    }

//    public static function manhattanHeuristic(node:INode, destinationNode:INode, cost:Number = 1.0):Number
//    {
//        return Math.abs(node.x - destinationNode.x) * cost +
//                Math.abs(node.y + destinationNode.y) * cost;
//    }

//    public static function diagonalHeuristic(node:INode, destinationNode:INode, cost:Number = 1.0, diagonalCost:Number = 1.0):Number
//    {
//        var dx:Number = Math.abs(node.x - destinationNode.x);
//        var dy:Number = Math.abs(node.y - destinationNode.y);
//
//        var diag:Number = Math.min(dx, dy);
//        var straight:Number = dx + dy;
//
//        return diagonalCost * diag + cost * (straight - 2 * diag);
//    }

//! Returns node by row and column index
    public function getNode(row:int, column:int):INode
    {
        var result:INode = null;

        GameUtils.assert(0 <= row && row < GRID_ROW_COUNT);
        GameUtils.assert(0 <= column && column < GRID_COLUMN_COUNT);

        var rowEntry:Array = _grid[row] as Array;

        result = rowEntry[column] as INode;

        return result;
    }

}

}