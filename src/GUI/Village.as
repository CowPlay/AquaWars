/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/19/13
 * Time: 1:46 PM
 * To change this template use File | Settings | File Templates.
 */
package GUI {
import GUI.Panels.ActionPanel;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import models.ResourceManager.ResourceManagerGUI;

import mx.resources.ResourceBundle;

import scenes.AquaWars;

import scenes.AquaWars;
import scenes.views.BaseView;

//Class
public class Village extends BaseView
{
    private var _actionBar: ActionPanel;
    private var _buttonMap: Sprite;

    public function Village()
    {
       _actionBar = new ActionPanel;
       _buttonMap = new ResourceManagerGUI.buttonMapClass();
       _buttonMap.x = 5;
       _buttonMap.y = 5;
        _buttonMap.addEventListener(MouseEvent.CLICK, removeFromChoiceGameWorld);
       _actionBar.addChild(_buttonMap);
       _actionBar.x = 359.85;
       _actionBar.y = 677.45;
       AquaWars.scene.stage.addChild(_actionBar);
    }

    private function removeFromChoiceGameWorld(e: Event):void
    {
        AquaWars.scene.stage.removeChild(_actionBar);
        AquaWars._interface.container.removeChild(this);
        var choiceWorld: ChoiceWorld = new ChoiceWorld();
        AquaWars._interface.container.addChild(choiceWorld);
    }


}
}
