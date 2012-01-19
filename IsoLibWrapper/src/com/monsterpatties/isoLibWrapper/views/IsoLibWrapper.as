package com.monsterpatties.isoLibWrapper.views
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.Stroke;
	import caurina.transitions.Tweener;
	import com.bit101.Grid;
	import com.monsterpatties.isoLibWrapper.data.IsoWorldConfig;
	import com.monsterpatties.isoLibWrapper.events.IsoLibWrapperEvent;
	import eDpLib.events.ProxyEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author monsterpatties
	 */
	public class IsoLibWrapper extends Sprite
	{
		/*----------------------------------------------------------------------------------Constant-------------------------------------------------------------*/
		//best setup 800 600
		private var _isoViewWidth:int = 800;
		private var _isoViewHeight:int = 600;
		
		//best setup 8,8,0,50
		private var _isoGridWidth:int = 8;
		private var _isoGridLength:int = 8;
		private var _isoGridHeight:int = 0;
		private var _isoGridCellSize:int = 50;
		
		//best setup 200, 200
		private var _isoViewCenterX:int = 200;
		private var _isoViewCenterY:int = 200;
		/*----------------------------------------------------------------------------------Properties-----------------------------------------------------------*/
		private var _isoGrid:IsoGrid;
		private var _isoScene:IsoScene;
		private var _isoView:IsoView;
		
		//debug mode 
		private var _isoBox:IsoBox;
		private var _isoGrid2:IsoGrid;
		private var _isoScene2:IsoScene;
		private var _isoView2:IsoView;
		
		//
		private var _currentIsoObject:IsoSprite;
		private var  _isoObjects:Array;
		
		//path finding things
		private var _pathGrid:Grid;
		
		//interactivity
		private var _panPoint:Point;
		private var _dragPoint:Point;
		private var _zoom:Number = 1;
		
		//move, rotate, sell
		private var _currentInterAction:String = "";
		/*----------------------------------------------------------------------------------Constructor----------------------------------------------------------*/
		
		
		
		public function IsoLibWrapper()
		{			
			initIsoWorldData();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}		
		
		
		private function init(e:Event):void
		{			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			initIsoWorld();
		}
		
		private function destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
		
		}
		
		/*----------------------------------------------------------------------------------Methods-------------------------------------------------------------*/
		
		private function initIsoWorldData():void 
		{			
			_isoViewWidth = IsoWorldConfig.ISO_VIEW_WIDTH;
			_isoViewHeight = IsoWorldConfig.ISO_VIEW_HEIGHT;
			_isoGridWidth = IsoWorldConfig.ISO_GRID_WIDTH;
			_isoGridLength = IsoWorldConfig.ISO_GRID_LENGTH;
			_isoGridHeight = IsoWorldConfig.ISO_GRID_HEIGHT;
			_isoGridCellSize = IsoWorldConfig.ISO_GRID_CELL_SIZE;
			_isoViewCenterX = IsoWorldConfig.ISO_VIEW_CENTER_X;
			_isoViewCenterY = IsoWorldConfig.ISO_VIEW_CENTER_Y;
		}
		
		private function initIsoWorld():void
		{
			_pathGrid = new Grid( _isoGridWidth, _isoGridLength );
			_isoScene = new IsoScene();
			addGrid();
			
			var isoObjet:IsoObject;
			
			for (var i:int = 0; i < _isoGridWidth; i++)
			{
				for (var j:int = 0; j < _isoGridLength; j++)
				{
					//set tiles
					isoObjet = new IsoObject(0, j * _isoGridCellSize, i * _isoGridCellSize, 1);					
					_pathGrid.setWalkable( j,i , true );
					_isoScene.addChild(isoObjet.isoSprite);
				}
			}	
			
			_isoScene.render();
			
			//view port
			_isoView = new IsoView();
			_isoView.setSize(_isoViewWidth, _isoViewHeight);
			_isoView.centerOnPt(new Pt(_isoViewCenterX, _isoViewCenterY, 0));
			_isoView.addScene(_isoScene);			
			addChild(_isoView);						
			
			//adds on for testing experiment
			_isoScene2 = new IsoScene();			
			addGrid2();
			
			//_isoView2 = new IsoView();
			//_isoView2.setSize(_isoViewWidth, _isoViewHeight);
			//_isoView2.centerOnPt(new Pt(_isoViewCenterX, _isoViewCenterY, 0));
			//_isoView2.addScene(_isoScene2);
			//addChild( _isoView2 );
			
			_isoView.addScene( _isoScene2 );
		
			setWorldObject();
			
			addEventListener(Event.ENTER_FRAME, onGameLoop);
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onStartPan , false, 0 , true );
			stage.addEventListener( MouseEvent.MOUSE_WHEEL, onZoom, false, 0, true );
		}				
		
		public function removeGrid():void
		{
			if (_isoScene.contains(_isoGrid))
			{
				_isoScene.removeChild(_isoGrid);
				_isoGrid = null;
			}
		}
		
		public function addGrid():void
		{
			_isoGrid = new IsoGrid();
			_isoScene.addChild(_isoGrid);
			_isoGrid.showOrigin = false;
			
			_isoGrid.setGridSize(_isoGridWidth, _isoGridLength, _isoGridHeight);
			_isoGrid.gridlines = new Stroke(1, 0x00000000);
			_isoGrid.cellSize = _isoGridCellSize;			
		}
		
		public function addGrid2():void
		{			
			_isoGrid2 = new IsoGrid();
			_isoScene2.addChild(_isoGrid2);
			
			_isoGrid2.setGridSize(_isoGridWidth, _isoGridLength, _isoGridHeight);
			_isoGrid2.gridlines = new Stroke(1, 0x00000000);
			_isoGrid2.cellSize = _isoGridCellSize;
			_isoGrid2.showOrigin = false;
			
			//for debug
			//_isoBox = new IsoBox();
			//_isoBox.setSize(_isoGridCellSize, _isoGridCellSize, _isoGridCellSize );
			//_isoBox.moveTo(_isoGridCellSize, _isoGridCellSize, 0);						
			//_isoScene2.addChild(_isoBox);			
			
			//_isoGrid2.addEventListener(MouseEvent.MOUSE_MOVE, onGridMove )			
			//_isoGrid2.addEventListener(MouseEvent.CLICK, onGridClick)
			
		}		
		
		public function showOrigin():void
		{
			if (_isoGrid != null)
			{
				_isoGrid.showOrigin = true;
			}
		}
		
		public function hideOrigin():void
		{
			if (_isoGrid != null)
			{
				_isoGrid.showOrigin = false;
			}
		}
		
		private function setWorldObject():void 
		{
			_isoObjects = new Array();
			var isoObject:IsoObject;
			
			for (var i:int = 0; i < _isoGridWidth; i++)
			{
				for (var j:int = 0; j < _isoGridLength; j++)
				{
					if (Math.random() > 0.5)
					{					
						isoObject = new IsoObject(1, j * _isoGridCellSize, i * _isoGridCellSize, 1);
						_pathGrid.setWalkable( j,i , false );
						isoObject.isoSprite.addEventListener( MouseEvent.MOUSE_UP, onSelectIsoObject );						
						_isoScene2.addChild(isoObject.isoSprite);
						_isoObjects.push( isoObject );
					}					
				}
			}
			
			_isoScene2.render();
		}	
		
		
		private function getIsoObjectbyIsoSprite( isoSprite:IsoSprite ):IsoObject 
		{
			var isoObject:IsoObject = null;
			var len:int = _isoObjects.length;
			
			for (var i:int = 0; i < len ; i++) 
			{
				if ( _isoObjects[ i ].isoSprite == isoSprite ){
					isoObject = _isoObjects[ i ];					
					break;
				}
			}			
			return isoObject;
		}	
		
		
		private function stopPan():void 
		{
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onPan );			
			stage.removeEventListener( MouseEvent.MOUSE_UP, onStopPan );
			stage.addEventListener( MouseEvent.MOUSE_DOWN, onStartPan,false, 0, true );
		}
		
		/*----------------------------------------------------------------------------------Setters-------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------------------Getters------------------------------------------------------------*/
		
		/*----------------------------------------------------------------------------------EventHandlers-------------------------------------------------------*/
		private function onGameLoop(e:Event):void
		{
			_isoScene.render();
			_isoScene2.render();
		}
		
		private function onGridClick(e:ProxyEvent):void
		{
			var me:MouseEvent = MouseEvent(e.targetEvent);
			var p:Pt = new Pt( me.localX, me.localY );			
			trace( "p",p.x, p.y );
			IsoMath.screenToIso( p );
			
			var gridX:int = ( Math.floor(p.x / _isoGridCellSize) * _isoGridCellSize ) / _isoGridCellSize;
			var gridY:int = ( Math.floor(p.y / _isoGridCellSize) * _isoGridCellSize ) / _isoGridCellSize;
			
			var gridXInPixel:int = ( Math.floor(p.x / _isoGridCellSize) * _isoGridCellSize );
			var gridYInPixel:int = ( Math.floor(p.y / _isoGridCellSize) * _isoGridCellSize );
			trace( "gridX", gridX, "gridY", gridY  );
			
			
			if ( gridX >= 0 && gridX < _isoGridWidth && gridY >= 0 && gridY < _isoGridLength ) {
				//test placing by click
				//var isoBox2:IsoBox = new IsoBox();
				//isoBox2.setSize(_isoGridCellSize, _isoGridCellSize, _isoGridCellSize );
				//isoBox2.moveTo(Math.floor(p.x / _isoGridCellSize) * _isoGridCellSize, Math.floor(p.y / _isoGridCellSize) * _isoGridCellSize, 0 );				
				//_isoScene2.addChild(isoBox2);
				
				//var isoObjet:IsoObject = new IsoObject( 1,gridXInPixel, gridYInPixel, 0 );
				//_isoScene2.addChild( isoObjet.isoSprite );				
			}			
		}
		
		private function onGridMove(e:ProxyEvent):void 
		{
			var me:MouseEvent = MouseEvent(e.targetEvent);
			var p:Pt = new Pt( me.localX, me.localY );			
			IsoMath.screenToIso( p );			
			var gridX:int = ( Math.floor(p.x / _isoGridCellSize) * _isoGridCellSize ) / _isoGridCellSize;
			var gridY:int = ( Math.floor(p.y / _isoGridCellSize) * _isoGridCellSize ) / _isoGridCellSize;
			trace( "gridX", gridX, "gridY", gridY );
			
			if ( gridX >= 0 && gridX < _isoGridWidth && gridY >= 0 && gridY < _isoGridLength ) {
				//used for 2nd stack of object
				_isoBox.moveTo(Math.floor(p.x / _isoGridCellSize) * _isoGridCellSize, Math.floor(p.y / _isoGridCellSize) * _isoGridCellSize, _isoGridCellSize / 2 );
				//used this for 2nd but plat stacking like grass and tiles
				//_isoBox.moveTo(Math.floor(p.x / _isoGridCellSize) * _isoGridCellSize, Math.floor(p.y / _isoGridCellSize) * _isoGridCellSize, 1 );			
			}
		}
		
		private function onSelectIsoObject(e:ProxyEvent):void 
		{	
			if ( _currentInterAction == "" ){				
				_currentInterAction = "move";			
				
				var isoObject:IsoObject = getIsoObjectbyIsoSprite( e.target as IsoSprite );
				
				/*
				_dragPoint = _isoView.localToIso(new Pt(stage.mouseX, stage.mouseY));
				_dragPoint.x -= isoObject.isoSprite.x;
				_dragPoint.y -= isoObject.isoSprite.y;
				*/
				
				isoObject.selected();
				_pathGrid.setWalkable( isoObject.gridX, isoObject.gridY , true );			
				_currentIsoObject = isoObject.isoSprite;			
				//addEventListener( Event.ENTER_FRAME, onDragIsoObject );				
				addEventListener( MouseEvent.MOUSE_MOVE, onDragIsoObject );
			}
			
			stopPan();
		}
		
		private function onDragIsoObject(e:MouseEvent):void 
		{
			_currentIsoObject.addEventListener( MouseEvent.CLICK, onDropIsoObject );
			
			// var pt:Pt = _isoView.localToIso(new Pt(e.stageX, e.stageY )); 
			//_currentIsoObject.moveTo( pt.x - _dragPoint.x, pt.y - _dragPoint.y, 0 );			
			
			var pt:Pt = _isoView.localToIso( new Point( e.stageX, e.stageY )  );			
			var gridX:int = ( Math.floor(pt.x / _isoGridCellSize) * _isoGridCellSize ) / _isoGridCellSize;
			var gridY:int = ( Math.floor(pt.y / _isoGridCellSize) * _isoGridCellSize ) / _isoGridCellSize;
			var pixelX:int = (  Math.floor(pt.x / _isoGridCellSize) * _isoGridCellSize );
			var pixelY:int = ( Math.floor(pt.y / _isoGridCellSize) * _isoGridCellSize );
			
			//trace( "[ IsoLibWrapper ] draging isoObject gridX", gridX, "gridY", gridY, "isWalkable", _pathGrid.getWalkable( gridX, gridY , _isoGridWidth, _isoGridLength ) );
			//trace( "[IsoLibWrapper]: move to pixelX ", pixelX, "pixelY", pixelY  );
			
			if ( gridX >= 0 && gridX < _isoGridWidth && gridY >= 0 && gridY < _isoGridLength  && _pathGrid.getWalkable( gridX, gridY , _isoGridWidth, _isoGridLength ) ) {
				_currentIsoObject.moveTo( pixelX, pixelY, 0  );
			}			
		}
		
		private function onDropIsoObject(e:ProxyEvent):void 
		{
			var pt:Pt = _isoView.localToIso( new Point( stage.mouseX , stage.mouseY )  );			
			var gridX:int = ( Math.floor(pt.x / _isoGridCellSize) * _isoGridCellSize ) / _isoGridCellSize;
			var gridY:int = ( Math.floor(pt.y / _isoGridCellSize) * _isoGridCellSize ) / _isoGridCellSize;			
			var pixelX:int = Math.floor(pt.x / _isoGridCellSize) * _isoGridCellSize;
			var pixelY:int = Math.floor(pt.y / _isoGridCellSize) * _isoGridCellSize;
			
			if ( gridX >= 0 && gridX < _isoGridWidth && gridY >= 0 && gridY < _isoGridLength &&  _pathGrid.getWalkable( gridX, gridY , _isoGridWidth, _isoGridLength )  ) {
				
				var isoObject:IsoObject = getIsoObjectbyIsoSprite( e.target as IsoSprite );
				isoObject.deselected();
				_pathGrid.setWalkable( gridX, gridY , false );				
				isoObject.gridX = gridX;
				isoObject.gridY = gridY;				
				//removeEventListener( Event.ENTER_FRAME, onDragIsoObject );				
				removeEventListener( MouseEvent.MOUSE_MOVE, onDragIsoObject );				
				_currentIsoObject.removeEventListener( MouseEvent.CLICK, onDropIsoObject );			
				_currentIsoObject.addEventListener( MouseEvent.MOUSE_UP, onSelectIsoObject );
				_currentIsoObject.moveTo( pixelX, pixelY, 0  );				
				_currentInterAction = "";				
				trace( "[isoLibWrapper] place isoObject successfully" );
			}else {
				trace( "[isoLibWrapper] can't place isoObject here its not walkable" );
			}
			
			stopPan();
		}		
		
		private function onStartPan(e:MouseEvent):void 
		{			
			_panPoint = new Point(  stage.mouseX, stage.mouseY  );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onPan, false, 0 ,true );
			stage.addEventListener( MouseEvent.MOUSE_UP, onStopPan , false, 0 ,true );			
			stage.removeEventListener( MouseEvent.MOUSE_DOWN, onStartPan );
		}
		
		private function onPan(e:MouseEvent):void 
		{			
			_isoView.panBy( _panPoint.x - stage.mouseX, _panPoint.y - stage.mouseY );
			_panPoint.x = stage.mouseX;
			_panPoint.y = stage.mouseY;
		}
		
		private function onStopPan(e:MouseEvent):void 
		{
			stopPan();
		}
		
		private function onZoom( e:MouseEvent ):void
        {			
			if ( e.delta > 0 ) {
				if( _zoom < 1 ){
					_zoom += 0.1
				}
			}else {
				if( _zoom > 0.5 ){
					_zoom -= 0.1;
				}
			}
			
			trace( "_zoom", _zoom );
 
            Tweener.addTween( _isoView, { currentZoom:_zoom, time:0.5 } );
        }
	}
}