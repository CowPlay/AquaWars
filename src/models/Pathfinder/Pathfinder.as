package models.Pathfinder
{
import flash.utils.Dictionary;

import gameObjects.Houses.Barracks.Barracks;
import gameObjects.Houses.Base.EHouseOwner;
import gameObjects.Houses.Base.HouseBase;

import models.GameConstants.GameConstants;
import models.GameInfo.GameInfo;

//! Class which contains info about level grid and provide find path functionally
public class Pathfinder
{
    /*
     * Static methods
     */

    private static function getPathHash(nodeFrom:INode, nodeTo:INode):String
    {
        return  nodeFrom.toString() + "#" + nodeTo.toString();
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

    //! Default constructor
    public function Pathfinder()
    {
        init();
    }

    private function init():void
    {
        _pathsCache = new Dictionary();

        { // Create grid
            _grid = [];

            for (var row:int = 0; row < GameConstants.GRID_ROW_COUNT; row++)
            {
                var newRow:Array = [];

                for (var column:int = 0; column < GameConstants.GRID_COLUMN_COUNT; column++)
                {
                    var newNode:INode = new Node(column, row);

                    newRow.push(newNode);
                }

                _grid.push(newRow);
            }
        }
    }

    public function getPath(nodeFrom:INode, nodeTo:INode):Array
    {
        var result:Array;

        var pathHash:String = getPathHash(nodeFrom, nodeTo);

        Debug.assert(_pathsCache[pathHash] != null);

        return  _pathsCache[pathHash].nodePathClone;
    }

    public function generateLevelPaths():void
    {
        for each(var houseFrom:HouseBase in GameInfo.Instance.houseManager.houses)
        {
            for each(var houseTo:HouseBase in GameInfo.Instance.houseManager.houses)
            {
                if (houseFrom == houseTo)
                {
                    continue;
                }

                var pathHash:String = getPathHash(houseFrom.houseExitPosition, houseTo.houseExitPosition);

                if (_pathsCache[pathHash] == null)
                {
                    generateAndAddPath(houseFrom.houseExitPosition, houseTo.houseExitPosition);
                }
            }
        }
    }

    private function generateAndAddPath(nodeFrom:INode, nodeTo:INode):void
    {
        var pathHash:String = getPathHash(nodeFrom, nodeTo);

        var openNodes:Array = [];
        var closedNodes:Array = [];

        var currentNode:INode = nodeFrom;
        var testNode:INode;

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

            for (var i:int = 0; i < connectedNodes.length; ++i)
            {
                testNode = connectedNodes[i];

                if (testNode == currentNode || testNode.traversable == false)
                {
                    continue;
                }

                //For our example we will test just highlight all the tested nodes
                if (GameConstants.SHOW_ASTAR_PATH_DEBUG)
                {
                    testNode.drawDebugData(0x1275D6);
                }

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
                //path does not exist
                Debug.assert(false);
            }

            openNodes.sortOn('f', Array.NUMERIC);
            currentNode = openNodes.shift() as INode;
        }

        var generatedPath:Array = BuildPath(nodeTo, nodeFrom);

        {//add to cache
            //Add finded path to cache
            _pathsCache[pathHash] = new PathFindedInfo(nodeFrom, nodeTo, generatedPath);
        }

        {
            //get info for reversed path
            var pathHashReversed:String = getPathHash(nodeTo, nodeFrom);

            var generatedPathReversed:Array = [];

            for (var nodeIndex:int = generatedPath.length - 1; nodeIndex >= 0; nodeIndex--)
            {
                generatedPathReversed.push(generatedPath[nodeIndex]);
            }

            //Add reversed path to cache
            _pathsCache[pathHashReversed] = new PathFindedInfo(nodeTo, nodeFrom, generatedPathReversed);
        }

        if (GameConstants.SHOW_ASTAR_PATH_RESULT)
        {
            for each(var node:INode in generatedPath)
            {
                node.drawDebugData(0xFF80C0);
            }
        }
    }


    private function FindConnectedNodes(node:INode):Array
    {
        var result:Array = [];

        var rowMin:int = node.row > 0 ? node.row - 1 : 0;
        var rowMax:int = node.row < GameConstants.GRID_ROW_COUNT - 1 ? node.row + 1 : GameConstants.GRID_ROW_COUNT - 1;

        var columnMin:int = node.column > 0 ? node.column - 1 : node.column;
        var columnMax:int = node.column < GameConstants.GRID_COLUMN_COUNT - 1 ? node.column + 1 : GameConstants.GRID_COLUMN_COUNT - 1;

        for (var currentRow:int = rowMin; currentRow <= rowMax; currentRow++)
        {
            var row:Array = _grid[currentRow];

            for (var column:int = columnMin; column <= columnMax; column++)
            {
                var connectedNode:INode = row[column];

                //TODO: test it
                if (connectedNode == node)
                {
                    continue;
                }

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
    private static function euclidianHeuristic(node:INode, destinationNode:INode, cost:Number = 1.0):Number
    {
        var dx:Number = node.column - destinationNode.column;
        var dy:Number = node.row - destinationNode.row;

        return Math.sqrt(dx * dx + dy * dy) * cost;
    }

//    public static function manhattanHeuristic(node:INode, destinationNode:INode, cost:Number = 1.0):Number
//    {
//        return Math.abs(node.column - destinationNode.column) * cost +
//                Math.abs(node.row + destinationNode.row) * cost;
//    }
//
//    public static function diagonalHeuristic(node:INode, destinationNode:INode, cost:Number = 1.0, diagonalCost:Number = 1.0):Number
//    {
//        var dx:Number = Math.abs(node.column - destinationNode.column);
//        var dy:Number = Math.abs(node.row - destinationNode.row);
//
//        var diag:Number = Math.min(dx, dy);
//        var straight:Number = dx + dy;
//
//        return diagonalCost * diag + cost * (straight - 2 * diag);
//    }

//! Returns node by row and column index
    public function getNode(column:int, row:int):INode
    {
        var result:INode = null;

        Debug.assert(0 <= row && row < GameConstants.GRID_ROW_COUNT);
        Debug.assert(0 <= column && column < GameConstants.GRID_COLUMN_COUNT);

        var rowEntry:Array = _grid[row] as Array;

        result = rowEntry[column] as INode;

        return result;
    }


    //! Returns nearest house with specify type. If type = null, returns house with any type
    public function getNearestHouse(target:HouseBase, type:EHouseOwner = null):HouseBase
    {
        var result:HouseBase = null;

        var minPath:Array = null;

        for each (var house:HouseBase in GameInfo.Instance.houseManager.houses)
        {
            if (house == target)
            {
                continue;
            }

            if (type != null && house.ownerType != type)
            {
                continue;
            }

            var path:Array = getPath(target.houseExitPosition, house.houseExitPosition);

            if (minPath == null)
            {
                minPath = path;
                result = house;
            }
            else
            {
                minPath = path.length < minPath.length ? path : minPath;
                result = house;
            }
        }

        return result;
    }


}

}