package com.monsterpatties.isoLibWrapper.test 
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.Stroke;
	import com.greensock.TweenMax;
	import com.monsterpatties.isoLibWrapper.views.IsoObject;
	import eDpLib.events.ProxyEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author monsterpatties
	 */	
	
	public class IsoLibWrapperTest extends Sprite
	{
		/*------------------------------------------------------------------------Constant------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Properties----------------------------------------------------------------*/
		private var _isoGrid:IsoGrid;
		private var _isoScene:IsoScene;
		private var _isoView:IsoView;
		
		private static const ISO_VIEW_WIDTH:Number = 800;
		private static const ISO_VIEW_HEIGHT:Number = 600;
		private static const ISO_GRID_WIDTH:Number = 8;
		private static const ISO_GRID_LENGTH:Number = 8;
		private static const ISO_GRID_HEIGHT:Number = 0;
		private static const ISO_GRID_CELL_SIZE:Number = 50;
		
		private static const ISO_VIEW_CENTER_X:Number = 200;
		private static const ISO_VIEW_CENTER_Y:Number = 200;
		
		private var _isoBox:IsoBox;
		
		private var _isoObject:IsoObject;
		/*------------------------------------------------------------------------Constructor---------------------------------------------------------------*/
		
		public function IsoLibWrapperTest() 
		{
			//guide
			_isoGrid = new IsoGrid();			
			_isoGrid.addEventListener( MouseEvent.MOUSE_MOVE, onGridClick )
			_isoGrid.setGridSize( ISO_GRID_WIDTH, ISO_GRID_LENGTH, ISO_GRID_HEIGHT );
			_isoGrid.gridlines =    new Stroke( 1, 0x00000000 );
			_isoGrid.cellSize = ISO_GRID_CELL_SIZE;
			_isoGrid.showOrigin = false;
			
			
			_isoBox = new IsoBox();
			_isoBox.setSize( ISO_GRID_CELL_SIZE, ISO_GRID_CELL_SIZE, 50  );			
			_isoBox.moveTo( ISO_GRID_CELL_SIZE, ISO_GRID_CELL_SIZE, 0 );
			//the renderer
			
			_isoScene = new IsoScene();
			_isoScene.addChild( _isoGrid );			
			_isoScene.addChild( _isoBox );
			
			
			for (var i:int = 0; i < 8; i++)
			{
				for (var j:int = 0; j < 8; j++) 
				{							
					if (  Math.random() > 0.5 ) {
						_isoObject = new IsoObject( 1, j * ISO_GRID_CELL_SIZE, i * ISO_GRID_CELL_SIZE, 0 );						
					}else {						
						_isoObject = new IsoObject( 0, j * ISO_GRID_CELL_SIZE, i * ISO_GRID_CELL_SIZE, 0 );
					}										
					_isoScene.addChild( _isoObject.isoSprite );
				}
			}		
			
			_isoScene.render();
			
			//view port
			_isoView = new IsoView();
			_isoView.setSize( ISO_VIEW_WIDTH, ISO_VIEW_HEIGHT );
			_isoView.centerOnPt( new Pt( ISO_VIEW_CENTER_X, ISO_VIEW_CENTER_Y, 0 ) );
			_isoView.addScene( _isoScene );
			addChild( _isoView );
			
			addEventListener( Event.ENTER_FRAME, onGameLoop );
		}			
		
		/*------------------------------------------------------------------------Methods------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Setters------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------Getters------------------------------------------------------------------*/
		
		/*------------------------------------------------------------------------EventHandlers------------------------------------------------------------*/
		private function onGridClick(e:ProxyEvent):void 
		{
			var me:MouseEvent = MouseEvent( e.targetEvent );
			var p:Pt = new Pt( me.localX, me.localY );
			IsoMath.screenToIso( p );
			_isoBox.moveTo( Math.floor ( p.x / ISO_GRID_CELL_SIZE) * ISO_GRID_CELL_SIZE ,  Math.floor ( p.y / ISO_GRID_CELL_SIZE) * ISO_GRID_CELL_SIZE, 0 );			
		}		
		
		private function onGameLoop(e:Event):void 
		{
			_isoScene.render();
		}
	}

}