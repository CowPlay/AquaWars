/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/10/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
package models.Game
{
import models.Players.Player;

//! Base class of all game types
public class GameBase
{
    /*
     * Fields
     */

    protected var _gameOwner:Player;
    protected var _gameOwnerOpponent:Player;

    /*
     * Properties
     */

    public function get gameOwner():Player
    {
        return _gameOwner;
    }

    public function get gameOwnerOpponent():Player
    {
        return _gameOwnerOpponent;
    }

    public function get type():EGameType
    {
        Debug.assert(false);
        return null;
    }

    /*
     * Methods
     */

    //! Default constructor
    public function GameBase()
    {
    }
}
}
