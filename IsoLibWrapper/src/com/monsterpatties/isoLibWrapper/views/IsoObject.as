package com.monsterpatties.isoLibWrapper.views 
{
	import as3isolib.display.IsoSprite;
	import com.greensock.TweenMax;
	import com.monsterpatties.isoLibWrapper.data.IsoWorldConfig;
	import eDpLib.events.ProxyEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class IsoObject extends Sprite
	{
		/*------------------------------------------------------------------------------Constant--------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------------Properties------------------------------------------------------------*/
		private var _isoSprite:IsoSprite;
		private var _skinMC:MovieClip;		
		private var _skin:int;
		
		//size per grid
		private var _gridX:int;
		private var _gridY:int;
		private var _gridZ:int;
		
		//size in pixel
		private var _pixelX:int;
		private var _pixelY:int;
		private var _pixelZ:int;
		
		private var _isSelected:Boolean;
		/*------------------------------------------------------------------------------Constructor-----------------------------------------------------------*/
		
		
		public function IsoObject( skin:int, gridX:int, gridY:int, gridZ:int  ) 
		{
			_skin = skin;
			_pixelX = gridX;
			_pixelY = gridY;
			_pixelZ = gridZ;			
			setDisplay();
		}		
		
		
		/*------------------------------------------------------------------------------Methods--------------------------------------------------------------*/
		private function setDisplay():void 
		{
			trace( "skin",_skin	 );
			_isoSprite = new IsoSprite();			
			
			//_skinMC.gotoAndStop( _skin );
			//_isoSprite.sprites = [ _skinMC ];
			
			_isoSprite.setSize( 50, 50, 50 );
			
			if ( _skin == 0 ) {
				_skinMC = new Grass();
				//addChild( _skinMC );
				_skinMC.buttonMode  = true;
				_isoSprite.sprites = [ _skinMC ];
			}else {
				_skinMC = new Brick();
				//addChild( _skinMC );
				_skinMC.buttonMode  = true;
				_isoSprite.sprites = [ _skinMC ];
			}			
			
			_isoSprite.moveBy( _pixelX, _pixelY , _pixelZ );
			
			_gridX = _pixelX / IsoWorldConfig.ISO_GRID_CELL_SIZE;
			_gridY = _pixelY / IsoWorldConfig.ISO_GRID_CELL_SIZE
			_gridZ = _pixelZ;
			
			_isoSprite.addEventListener( MouseEvent.MOUSE_UP, onSelectIsoObject );
		}
		
		
		public function selected():void 
		{
			_isoSprite.container.filters  = [ new GlowFilter( 0xFF0000, 1, 4,4,48 ) ];
		}
		
		public function deselected():void 
		{
			_isoSprite.container.filters  = [  ];
		}
		
		/*------------------------------------------------------------------------------Setters--------------------------------------------------------------*/
		public function set isoSprite(value:IsoSprite):void 
		{
			_isoSprite = value;
		}
		
		public function set isSelected(value:Boolean):void 
		{
			_isSelected = value;
		}
		
		public function set gridX(value:int):void 
		{
			_gridX = value;
		}
		
		public function set gridY(value:int):void 
		{
			_gridY = value;
		}
		
		public function set gridZ(value:int):void 
		{
			_gridZ = value;
		}		
		
		
		public function set pixelZ(value:int):void 
		{
			_pixelZ = value;
		}
		
		
		public function set pixelY(value:int):void 
		{
			_pixelY = value;
		}
		
		public function set pixelX(value:int):void 
		{
			_pixelX = value;
		}
		/*------------------------------------------------------------------------------Getters--------------------------------------------------------------*/
		public function get isoSprite():IsoSprite 
		{
			return _isoSprite;
		}
		
		public function get isSelected():Boolean 
		{
			return _isSelected;
		}		
		
		public function get gridX():int 
		{
			return _gridX;
		}	
		
		public function get gridY():int 
		{
			return _gridY;
		}		
		
		public function get gridZ():int 
		{
			return _gridZ;
		}
		
		public function get pixelX():int 
		{
			return _pixelX;
		}		
		
		public function get pixelY():int 
		{
			return _pixelY;
		}		
		
		public function get pixelZ():int 
		{
			return _pixelZ;
		}	
		
		/*------------------------------------------------------------------------------EventHandlers--------------------------------------------------------*/
		private function onRolloverIsoObject(e:ProxyEvent):void 
		{
			var iso:IsoSprite = e.proxy as IsoSprite;
			TweenMax.to( iso, 0.3, { z:100, yoyo:true , repeat:1,  startAt:{ z:0} } );			
		}	
		
		private function onSelectIsoObject(e:ProxyEvent):void 
		{
			//if( !_isSelected  ){
				//_isSelected = true;
				//trace( "[isoObject]: gridx", _gridX, "gridY", _gridY, "gridZ", _gridZ, "x", x, "y", y, "z", z );
				//var isolibWrapperEvent:IsoLibWrapperEvent = new IsoLibWrapperEvent( IsoLibWrapperEvent.ON_ISO_OBJECT_SELECTED );
				//dispatchEvent( isolibWrapperEvent );
			//}else {
				//_isSelected = false;
			//}
		}		
	}
}