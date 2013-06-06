/**
 * Created with IntelliJ IDEA.
 * User: gregorytkach
 * Date: 6/6/13
 * Time: 10:00 AM
 * To change this template use File | Settings | File Templates.
 */
package models.SharedSoldierGenerator
{
import gameObjects.House.House;

public class SoldierWaveInfo
{
    //TODO: add last generated time

    //TODO: make properties
    public var generatedSoldierMax:uint;

    public var owner:House;
    public var target:House;


    public function SoldierWaveInfo()
    {
    }
}
}
