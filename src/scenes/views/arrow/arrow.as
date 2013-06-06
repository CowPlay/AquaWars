/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/5/13
 * Time: 2:11 AM
 * To change this template use File | Settings | File Templates.
 */
package scenes.views.arrow
{
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import gameObjects.BaseView;
import gameObjects.House.House;

import models.ResourceManager.ResourceManager;

import scenes.AquaWars;

//TODO: make singleton and rename to Manager
public class arrow extends BaseView
{
    /*
     * Static fields
     */

    private static var _arrow:Sprite;

    /*
     * Static methods
     */

//    public static function OnHouseSelected(house:House):void
//    {
//        var _class: Class = ResourceManager.getSelectedArrow();
//
//        _arrow = new _class();
//        _arrow.scaleX = 0;
//        _rootView.addChild(_arrow);
//
//        AquaWars.scene.stage.addEventListener(MouseEvent.MOUSE_MOVE, changeSize);
//        AquaWars.scene.setChildIndex(_rootView, AquaWars.GetScene().numChildren - 1);
//
//        _rootView.setChildIndex(_arrow, 0);
//
//        AquaWars.scene.stage.addEventListener(MouseEvent.MOUSE_UP, removeArrow);
//    }
//
//    public static function OnHouseSelectionReset():void
//    {
//        AquaWars.scene.stage.removeEventListener(MouseEvent.MOUSE_MOVE, changeSize);
//        AquaWars.scene.stage.removeEventListener(MouseEvent.MOUSE_UP, removeArrow);
//
//        AquaWars.scene.stage.removeChild(_arrow);
//
//        _rootView.removeChild(_arrow);
//    }
//
//    private function changeSize(e: Event):void
//    {
//        var point: Point = new Point(AquaWars.GetScene().stage.mouseX, AquaWars.GetScene().stage.mouseY);
//        _arrow.scaleX = - Math.sqrt(Math.pow((point.x - _rootView.x), 2) + Math.pow((point.y - _rootView.y), 2))/174.8;
//        var angle: Number = Math.atan2(_rootView.y - point.y, _rootView.x - point.x)/Math.PI*180;
//        _arrow.rotation = angle;
//    }
//
//    private function removeArrow(e: Event):void
//    {
//        AquaWars.GetScene().stage.removeEventListener(MouseEvent.MOUSE_MOVE, changeSize);
//        AquaWars.GetScene().stage.removeEventListener(MouseEvent.MOUSE_UP, removeArrow);
//        _rootView.removeChild(_arrow);
//    }

    //! Default initializer
    public function arrow()
    {
    }
}
}
