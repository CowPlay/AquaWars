/**
 * Created with IntelliJ IDEA.
 * User: developer
 * Date: 6/21/13
 * Time: 12:31 PM
 * To change this template use File | Settings | File Templates.
 */
package GUI.Panels {
import models.ResourceManager.ResourceManagerGUI;

import scenes.views.BaseView;

public class TopPanel extends BaseView
{
    public function TopPanel()
    {
        eventHandler = this;
        addChild(new ResourceManagerGUI.topPanelClass())
    }
}
}
