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

import models.ResourceManager.ResourceManager;

public class ArrowView
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

    }

    public function didMouseMove(e:MouseEvent):void
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


}
}
