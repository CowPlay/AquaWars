/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/20/13
 * Time: 12:46 PM
 * To change this template use File | Settings | File Templates.
 */
package GUI {
import GUI.Panels.BottomPanel;
import GUI.Panels.TopPanel;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import models.ResourceManager.ResourceManager;

import models.ResourceManager.ResourceManagerGUI;

import scenes.views.BaseView;

public class Interface extends BaseView{

    /*
     * Fields
     */
    private var _topPanel: TopPanel;
    private var _bottomPanel: BottomPanel;
    private var _topBottomPanel: BottomPanel;
    private var _music: MovieClip;
    private var _photo: Sprite;
    private var _sound: MovieClip;
    private var _fullScreen: MovieClip;
    private var _container: Sprite;


    /*
     * Getters
     */
    public function get container():Sprite
    {
        return _container;
    }



    /*
     * Methods
     */

    //! Default constructor
    public function Interface()
    {
        eventHandler = this;


        var backgroundClass:Class = ResourceManager.getSceneBackground();
        _container = new backgroundClass();
        addChild(_container);


        initInterfaceElement();
        locateInterfaceElement();
        createVillage();
    }

    //! Init interface buttons
    private function initInterfaceElement():void
    {
        _bottomPanel = new BottomPanel();
        _topBottomPanel = new BottomPanel();
        _topPanel = new TopPanel();
        _music = new ResourceManagerGUI.musicClass();
        _photo = new ResourceManagerGUI.photoClass();
        _sound = new ResourceManagerGUI.soundClass();
        _fullScreen = new ResourceManagerGUI.fullScreenClass();
    }

    private function locateInterfaceElement():void
    {
        _bottomPanel.y = 710.15
        addChild(_bottomPanel);
        _topBottomPanel.y = 50;
        addChild(_topBottomPanel);
        addChild(_topPanel);
        _music.x = 924.05;
        _music.y = 722.85;
        _music.gotoAndStop(1);
        _music.addEventListener(MouseEvent.CLICK, glowingButton);
        _music.buttonMode = true;
        addChild(_music);
        _photo.x = 851.35;
        _photo.y = 724.75;
        addChild(_photo);
        _sound.x = 889.15;
        _sound.y = 723.3;
        _sound.gotoAndStop(1);
        _sound.addEventListener(MouseEvent.CLICK, glowingButton);
        addChild(_sound);
        _fullScreen.x = 960.2;
        _fullScreen.y = 722.7;
        _fullScreen.gotoAndStop(1);
        _fullScreen.addEventListener(MouseEvent.CLICK, glowingButton);
        addChild(_fullScreen);

    }


    private function glowingButton(e: Event):void
    {
        if (MovieClip(e.target).currentFrame == 1)
        {
            MovieClip(e.target).gotoAndStop(2);
        }
        else
        {
            MovieClip(e.target).gotoAndStop(1);
        }
    }


    private function createVillage():void
    {
        var village: Village = new Village();
        _container.addChild(village);
    }

}
}
