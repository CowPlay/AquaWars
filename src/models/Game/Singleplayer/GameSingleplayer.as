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
import models.Players.NPC.NPCLogic;

//! Class which represents singleplayer game.
public class GameSingleplayer extends GameBase
{

    /*
     * Properties
     */

    public override function get type():EGameType
    {
        return EGameType.EGT_SINGLEPLAYER;
    }

    /*
     * Methods
     */
    //! Default constructor
    public function GameSingleplayer()
    {
        _gameOwnerOpponent = new NPCLogic();

    }
}
}
