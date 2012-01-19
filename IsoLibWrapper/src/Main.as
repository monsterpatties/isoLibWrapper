package 
{	
	import com.monsterpatties.isoLibWrapper.test.IsoLibWrapperTest;
	import com.monsterpatties.isoLibWrapper.views.IsoLibWrapper;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * ...
	 * @author monsterpatties
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//var isoLibWrapperTest:IsoLibWrapperTest = new IsoLibWrapperTest();
			//addChild( isoLibWrapperTest );
			
			var isoLibWrapper:IsoLibWrapper = new IsoLibWrapper(  );
			addChild( isoLibWrapper );
			isoLibWrapper.hideOrigin();
			isoLibWrapper.removeGrid();
			//isoLibWrapper.showOrigin();
		}

	}

}