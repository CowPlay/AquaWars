/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/10/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
package models.Game.Singleplayer
{
import models.Game.EGameType;
import models.Game.GameBase;
import models.Game.Singleplayer.GameSingleplayerScene;
import models.GameInfo.GameInfo;
import models.Players.NPC.NPCLogic;

//! Class which represents singleplayer game.
public class GameSingleplayer extends GameBase
{
    /*
     * Fields
   */

    private var _scene: GameSingleplayerScene;



    /*
     * Properties
     */

    public override function get type():EGameType
    {
        return EGameType.EGT_SINGLEPLAYER;
    }

    public function get scene():GameSingleplayerScene
    {
        return _scene;
    }

    /*
     * Methods
     */
    //! Default constructor
    public function GameSingleplayer()
    {
        _gameOwnerOpponent = new NPCLogic();
        GameInfo.Instance.setCurrentGame(this);
        _scene = new GameSingleplayerScene();
        _scene.initHouses();

    }
}
}
