/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/14/13
 * Time: 4:16 PM
 * To change this template use File | Settings | File Templates.
 */
package gameObjects.Forge {
import gameObjects.House.EHouseType;
import gameObjects.House.House;

import models.StaticGameConfiguration.StaticGameConfiguration;

public class Forge extends House{
    public function Forge(type: EHouseType, soldierCount: int) {
        super (type, soldierCount);
    }

    override protected function didSetType():void
    {

        switch (_type)
        {
            case EHouseType.EHT_ENEMY:
            {
                StaticGameConfiguration.setNormalEnemyDamage(2);
                StaticGameConfiguration.setNormalPlayerDamage(1);
                break;
            }

            case EHouseType.EHT_PLAYER:
            {
                StaticGameConfiguration.setNormalPlayerDamage(2);
                StaticGameConfiguration.setNormalEnemyDamage(1);
                break;
            }

        }
    }
}
}
