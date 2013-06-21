/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/21/13
 * Time: 12:54 PM
 * To change this template use File | Settings | File Templates.
 */
package GUI.Buttons {
import flash.display.MovieClip;
import flash.display.Sprite;

import scenes.views.BaseView;

public class Music extends BaseView
{
    /*
     * Fields
     */
    private var _musicIcon: MovieClip;
    private var _musicContainer: Sprite;



    public function Music()
    {
        _musicContainer = new Sprite();
        _musicContainer.graphics.beginFill(0x000000, 0);
    }
}
}
