/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/19/13
 * Time: 12:23 PM
 * To change this template use File | Settings | File Templates.
 */
package GUI.Buttons {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import gameObjects.Houses.Barracks.Barracks;

import gameObjects.Houses.Base.EHouseType;

import gameObjects.Houses.Base.HouseBase;

import models.GameInfo.GameInfo;

import models.ResourceManager.ResourceManager;

import scenes.views.BaseView;

//!Class responsible on stop and play game
public class Pause extends BaseView{
    private var _viewStopGame: Sprite;
    private var _viewPlayGame: Sprite;
    //!contains stop and play buttons
    private var _pauseContainer:Sprite;

    public function Pause() {
        eventHandler = this;
        initPauseGUI();
    }

    private function initPauseGUI():void
    {
        _pauseContainer = new Sprite();

        addChild(_pauseContainer);

        _viewStopGame = new ResourceManager.PauseStopClass();
        _viewPlayGame = new ResourceManager.PausePlayClass();
        _viewStopGame.buttonMode = true;
        _viewPlayGame.buttonMode = true;
        _viewStopGame.addEventListener(MouseEvent.CLICK, stopGame);
        _viewPlayGame.addEventListener(MouseEvent.CLICK, playGame);

        _pauseContainer.addChild(_viewStopGame);

    }

    private function stopGame(e: Event):void
    {
        GameInfo.Instance.soldierGenerator.stopSoldiersMove();


        for each(var house:HouseBase in GameInfo.Instance.houseManager.houses)
        {
            house.view.stopAnimationHouseView();
            if(house.type == EHouseType.EHT_BARRACKS)
            {
                Barracks(house).stopSoldierGenerator();
            }
        }


        //_houseContainer.mouseChildren = false;

        _pauseContainer.removeChild(_viewStopGame);
        _pauseContainer.addChild(_viewPlayGame);
    }

    private function playGame(e: Event):void
    {
        GameInfo.Instance.soldierGenerator.playSoldiersMove();


        for each(var house:HouseBase in GameInfo.Instance.houseManager.houses)
        {
            house.view.playAnimationHouseView();
            if(house.type == EHouseType.EHT_BARRACKS)
            {
                Barracks(house).playSoldierGenerator();
            }
        }


        //_houseContainer.mouseChildren = true;

        _pauseContainer.removeChild(_viewPlayGame);
        _pauseContainer.addChild(_viewStopGame);
    }
}
}
