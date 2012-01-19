package com.monsterpatties.isoLibWrapper.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class IsoLibWrapperEvent extends Event 
	{
		/*--------------------------------------------------------------------Constant----------------------------------------------------------------*/
		public static const ON_ISO_OBJECT_SELECTED:String = "ON_ISO_OBJECT_SELECTED";
		public static const ON_MOUSE_UP_ISO_OBJECT:String = "ON_MOUSE_UP_ISO_OBJECT";
		/*--------------------------------------------------------------------Properties----------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Constructor----------------------------------------------------------------*/
		
		
		public function IsoLibWrapperEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		/*--------------------------------------------------------------------Methods----------------------------------------------------------------*/
		public override function clone():Event 
		{ 
			return new IsoLibWrapperEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("IsoLibWrapperEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		/*--------------------------------------------------------------------Setters----------------------------------------------------------------*/
		
		/*--------------------------------------------------------------------Getters----------------------------------------------------------------*/
		/*--------------------------------------------------------------------EventHandlers----------------------------------------------------------*/
		
	}
	
}