/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 5/31/13
 * Time: 11:43 AM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Soldier
{
import gameObjects.BaseView;

import models.ResourceManager.ResourceManager;

import flash.display.MovieClip;

public class SoldierView extends BaseView
{
    /*
     * Fields
     */
    private var _owner:Soldier;

    private var _soldierView:MovieClip;

    private var _soldierRotation:ESoldierRotation;
    /*
     * Properties
     */

    public function get owner():Soldier
    {
        return _owner;
    }

    public function set soldierRotation(value:ESoldierRotation):void
    {
        if (_soldierRotation == value)
        {
            return;
        }

        _soldierRotation = value;

        switch (_soldierRotation)
        {
            case ESoldierRotation.ESR_UP_LEFT:
            {
                _soldierView.gotoAndStop(0);
                break;
            }
            case ESoldierRotation.ESR_UP:
            {
                _soldierView.gotoAndStop(1);
                break;
            }
            case ESoldierRotation.ESR_UP_RIGHT:
            {
                _soldierView.gotoAndStop(2);
                break;
            }
            case ESoldierRotation.ESR_RIGHT:
            {
                _soldierView.gotoAndStop(3);
                break;
            }
            case ESoldierRotation.ESR_DOWN_RIGHT:
            {
                _soldierView.gotoAndStop(4);
                break;
            }
            case ESoldierRotation.ESR_DOWN:
            {
                _soldierView.gotoAndStop(5);
                break;
            }
            case ESoldierRotation.ESR_DOWN_LEFT:
            {
                _soldierView.gotoAndStop(6);
                break;
            }
            case ESoldierRotation.ESR_LEFT:
            {
                _soldierView.gotoAndStop(7);
                break;
            }
            default :
            {
                GameUtils.assert(false);
                break;
            }
        }
    }


    /*
     * Methods
     */

    //! Default constructor
    public function SoldierView(owner:Soldier)
    {
        GameUtils.assert(owner != null);

        _owner = owner;

        var soldierClass:Class = ResourceManager.getSoldierClassByOwnerTypeAndLevel(_owner.houseOwner.type);

        _soldierView = new soldierClass;

        this.eventHandler = _soldierView;

        addChild(_soldierView);
    }


    /*
     * IDisposable
     */

    public override function cleanup():void
    {
        removeChild(_soldierView);

        super.cleanup();
    }
}
}
