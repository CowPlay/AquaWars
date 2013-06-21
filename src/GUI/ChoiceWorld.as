/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/19/13
 * Time: 1:30 PM
 * To change this template use File | Settings | File Templates.
 */
package GUI {
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import models.ResourceManager.ResourceManagerGUI;

import scenes.AquaWars;

import scenes.AquaWars;

//! Class responsible from Choice World
public class ChoiceWorld extends Sprite
{

    private var _leftSwitchArrow: Sprite;
    private var _rightSwitchArrow: Sprite;
    private var _worldMapContainer: Sprite;
    private var _worldMapIndex: int;
    private var _worldMap: Sprite;

    public function ChoiceWorld()
    {
        _leftSwitchArrow = new ResourceManagerGUI.arrowSwitchClass();
        _leftSwitchArrow.x = 30.8;
        _leftSwitchArrow.y = 353.45;

        _leftSwitchArrow.addEventListener(MouseEvent.CLICK, leftArrowClick);


        _rightSwitchArrow = new ResourceManagerGUI.arrowSwitchClass();
        _rightSwitchArrow.scaleX = -1;
        _rightSwitchArrow.x = 963.8;
        _rightSwitchArrow.y = 353.45;

        _rightSwitchArrow.addEventListener(MouseEvent.CLICK, rightArrowClick);

        _worldMapContainer = new Sprite();
        _worldMapContainer.x = 287.55;
        _worldMapContainer.y = 165.4;

        _worldMapIndex = 1;
        var worldMapClass: Class = ResourceManagerGUI.getWorldMapBayNumber(_worldMapIndex);
        _worldMap = new worldMapClass();
        _worldMapContainer.addChild(_worldMap);

        _worldMapContainer.addEventListener(MouseEvent.CLICK, enterToTheWorld);

        addChild(_leftSwitchArrow);
        addChild(_rightSwitchArrow);
        addChild(_worldMapContainer);
    }


    private function leftArrowClick(e: Event):void
    {
        if (_worldMapIndex == 1)
        {
            _worldMapIndex = 3;
        }
        else
        {
            _worldMapIndex--;
        }

        _worldMapContainer.removeChild(_worldMap);


        var worldMapClass: Class = ResourceManagerGUI.getWorldMapBayNumber(_worldMapIndex);
        _worldMap = new worldMapClass();
        _worldMapContainer.addChild(_worldMap);
    }

    private function rightArrowClick(e: Event):void
    {
        if (_worldMapIndex == 3)
        {
            _worldMapIndex = 1;
        }
        else
        {
            _worldMapIndex++;
        }

        _worldMapContainer.removeChild(_worldMap);


        var worldMapClass: Class = ResourceManagerGUI.getWorldMapBayNumber(_worldMapIndex);
        _worldMap = new worldMapClass();
        _worldMapContainer.addChild(_worldMap);
    }


    private function enterToTheWorld(e: Event):void
    {
        switch (_worldMapIndex)
        {
            case 1:
            {

                AquaWars._interface.container.removeChild(this);
                AquaWars._interface.container.addChild(new GameMap());
                break;
            }
        }
    }
}
}
