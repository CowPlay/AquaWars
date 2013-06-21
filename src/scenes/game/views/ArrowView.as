/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/5/13
 * Time: 2:11 AM
 * To change this template use File | Settings | File Templates.
 */
package scenes.game.views
{
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import gameObjects.Houses.Base.HouseBase;

import models.ResourceManager.ResourceManager;

import scenes.views.BaseView;

public class ArrowView extends BaseView
{
    /*
     * Fields
     */

    private var _rootView:Sprite;

    private var _rootViewWidth:Number;
    /*
     * Properties
     */

    public function get rootView():Sprite
    {
        return _rootView;
    }

    public function get rootViewWidth():Number
    {
        return _rootViewWidth;
    }
    /*
     * Methods
     */

    //! Default initializer
    public function ArrowView()
    {
        init();
    }

    private function init():void
    {
        var arrowClass:Class = ResourceManager.getSelectedArrow();

        _rootView = new arrowClass();

        _rootViewWidth = _rootView.width;

        _rootView.scaleX = 0;

        eventHandler = _rootView;

    }

    public function DidMouseMove(e:MouseEvent):void
    {
        var rootViewPositionAbsolute:Point = _rootView.parent.localToGlobal(new Point(_rootView.x, _rootView.y));

        var point:Point = new Point(e.stageX, e.stageY);

        _rootView.scaleX = -Math.sqrt(Math.pow((point.x - rootViewPositionAbsolute.x), 2) + Math.pow((point.y - rootViewPositionAbsolute.y), 2)) / _rootViewWidth;

        _rootView.rotation = Math.atan2(rootViewPositionAbsolute.y - point.y, rootViewPositionAbsolute.x - point.x) / Math.PI * 180;
}

    public function show(isShow:Boolean):void
    {
        if (_rootView.visible == isShow)
            return;

        _rootView.visible = isShow;

        _rootView.scaleX = isShow ? _rootView.scaleX : 0;
    }

    public function magnetizeFromTargetHouse(targetHouse: HouseBase):void
    {
        var rootViewPositionAbsolute:Point = _rootView.parent.localToGlobal(new Point(_rootView.x, _rootView.y));
        _rootView.rotation = Math.atan2(rootViewPositionAbsolute.y - targetHouse.view.y, rootViewPositionAbsolute.x - targetHouse.view.x) / Math.PI * 180;
        var ellipseHalfWidth: Number = 70;
        var ellipseHalfHeight: Number = 30;
        var fi: Number = _rootView.rotation;
        var ellipseRadius: Number = ellipseHalfWidth*ellipseHalfHeight/Math.sqrt(Math.pow(ellipseHalfHeight, 2)*Math.pow(Math.cos(fi), 2) + Math.pow(ellipseHalfWidth, 2)*Math.pow(Math.sin(fi), 2));
        _rootView.scaleX = (-Math.sqrt(Math.pow((rootViewPositionAbsolute.x - targetHouse.view.x), 2) + Math.pow((rootViewPositionAbsolute.y - targetHouse.view.y), 2)) + ellipseRadius) / _rootViewWidth;

    }


}
}
