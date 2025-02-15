unit infopowr;

interface

{$R 'Info32.res'}

uses
Classes, DesignIntf, Buttons, Controls, DB,
ipabout, Wwdbgrid, Wwtable, wwdblook, wwidlg, Wwdbdlg, Wwprpedt, Wwquery, Wwkeycb, Wwdotdot, Wwdatsrc, Wwqbe, Wwlocate, Wwdbcomb, Wwdbspin, wwdbedit,
wwfltdlg, Wwintl, wwstorep, wwprpds, Wwdbigrd, wwDataInspector, wwInspectorPrpEdt, wwriched, wwDBNavigator, wwDBNavEdt, wwmonthcalendar, wwdbdatetimepicker,
wwrcdvw, wwrcdpnl, wwcheckbox, wwradiobutton, wwradiogroup, wwimagecombo, wwricheditbar;

procedure Register;

implementation

procedure Register;
begin
RegisterComponents('InfoPower Access', [ TwwDataSource, TwwTable, TwwQuery, TwwStoredProc, TwwQBE ] );
RegisterComponents('InfoPower Controls', [ TwwDBGrid, TwwDBNavigator, TwwDBEdit, TwwDBComboBox,
TwwDBSpinEdit, TwwDBComboDlg, TwwDBLookupCombo,
TwwDBLookupComboDlg, TwwKeyCombo, TwwIncrementalSearch,
TwwDBRichEdit, TwwDBMonthCalendar, TwwDBDateTimePicker,
TwwCheckBox, TwwExpandButton, TwwRadioGroup ] );
RegisterComponents('InfoPower Dialogs', [ TwwMemoDialog, TwwSearchDialog, TwwLocateDialog,
TwwLookupDialog, TwwFilterDialog, TwwRecordViewDialog,
TwwIntl ] );
RegisterComponents('InfoPower Controls', [ TwwRecordViewPanel, TwwDataInspector, TwwController,
TwwRichEditBar, TwwImageCombo ] );

RegisterComponentEditor( TwwDBGrid, TwwDBGridComponentEditor );
RegisterComponentEditor( TwwDBNavigator, TwwDBNavigatorEditor );
RegisterComponentEditor( TwwNavButton, TwwNavButtonEditor );

RegisterPropertyEditor( TypeInfo( TwwNavButtons ), TwwDBNavigator, '', TwwDBNavigatorButtonsEditor );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwDBGrid, 'ControlType', TSelectedFieldsProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwDBGrid, 'PictureMasks', TSelectedFieldsProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwDBGrid, 'Selected', TSelectedFieldsProperty );
RegisterPropertyEditor( TypeInfo( TwwRegexMask ), TwwCustomMaskEdit, '', TwwRegexProperty );
RegisterPropertyEditor( TypeInfo( TwwDBPicture ), TwwCustomMaskEdit, '', TwwPictureProperty );
RegisterPropertyEditor( TypeInfo( TwwDBPicture ), TwwInspectorItem, 'Picture', TwwObjPictureProperty );
RegisterPropertyEditor( TypeInfo( string ), TwwIncrementalSearch, 'PictureMask', TwwPicturePropertyGen );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwDBCustomLookupCombo, 'Selected', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwRecordViewDialog, 'Selected', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwDataInspector, 'Selected', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwRecordViewDialog, 'ControlType', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwRecordViewDialog, 'PictureMasks', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwRecordViewPanel, 'Selected', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwRecordViewPanel, 'ControlType', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwRecordViewPanel, 'PictureMasks', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwCustomLookupDialog, 'Selected', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwCustomLookupDialog, 'ControlType', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwCustomLookupDialog, 'PictureMasks', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwTable{TDataSet}, 'PictureMasks', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwTable{TDataSet}, 'ControlType', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwTable, 'LookupFields', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwTable, 'LookupLinks', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwQuery, 'LookupFields', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwQuery, 'LookupLinks', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwQBE, 'LookupFields', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwQBE, 'LookupLinks', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwStoredProc, 'LookupFields', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwStoredProc, 'LookupLinks', TwwTableDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwDBComboBox, 'Items', TwwComboItemsProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwInspectorPickList, 'Items', TwwComboItemsProperty );
RegisterPropertyEditor( TypeInfo( TwwDBPicture ), TwwDBEdit, 'Picture', TwwPictureProperty );
RegisterPropertyEditor( TypeInfo( string ), TwwDBLookupCombo, 'LookupField', TwwIndexFieldProperty );
RegisterPropertyEditor( TypeInfo( string ), TwwDBLookupComboDlg, 'LookupField', TwwIndexFieldProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwDBLookupComboDlg, 'ControlType', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwDBLookupComboDlg, 'PictureMasks', TwwDBLookupDisplayProperty );
RegisterPropertyEditor( TypeInfo( string ), TwwLocateDialog, 'SearchField', TwwSearchFieldProperty );
RegisterPropertyEditor( TypeInfo( string ), TwwFilterDialog, 'DefaultField', TwwSearchFieldProperty );
RegisterPropertyEditor( TypeInfo( TDataSet ), TwwDBCustomLookupCombo, 'LookupTable', TwwDataSetProperty );
RegisterPropertyEditor( TypeInfo( TwwTable ), TwwCustomLookupDialog, '', TwwTableProperty );
RegisterPropertyEditor( TypeInfo( string ), TwwInspectorItem, 'Caption', TwwMultiLineStringProperty );
RegisterPropertyEditor( TypeInfo( TDataSet ), TwwDataSource, 'DataSet', TwwDataSetProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwFilterDialog, 'SelectedFields', TwwFilterFieldsProperty );
RegisterPropertyEditor( TypeInfo( TStrings ), TwwCustomRichEdit, 'Lines', TwwRichEditItemsProperty );
RegisterPropertyEditor( TypeInfo( TSpeedButton ), TwwDBGrid, 'IndicatorButton', TwwGridIndicatorProperty );

RegisterComponentEditor( TwwDBLookupCombo, TwwDBLookupDisplayComponentEditor );
RegisterComponentEditor( TwwDBLookupComboDlg, TwwDBLookupDisplayComponentEditor );
RegisterComponentEditor( TwwLookupDialog, TwwDBLookupDisplayComponentEditor );
RegisterComponentEditor( TwwSearchDialog, TwwDBLookupDisplayComponentEditor );
RegisterComponentEditor( TwwCustomRichEdit, TwwRichEditComponentEditor );
RegisterComponentEditor( TwwRichEditBar, TwwRichEditBarComponentEditor );
RegisterComponentEditor( TwwDataInspector, TwwObjectViewComponentEditor );

RegisterPropertyEditor( TypeInfo( TWinControl ), TwwInspectorItem, 'CustomControl', TwwCustomEditPropertyEditor );
RegisterPropertyEditor( TypeInfo( string ), TwwInspectorItem, 'DataField', TwwDataFieldEditor );

RegisterComponentEditor( TwwRecordViewPanel, TwwRecordViewPanelComponentEditor );
RegisterComponentEditor( TwwRecordViewDialog, TwwRecordViewComponentEditor );

RegisterClasses( [ TwwIButton ] );

RegisterPropertyEditor( TypeInfo( TList ), TwwController, 'ControlList', TwwControllerListProperty );
RegisterPropertyEditor( TypeInfo( TwwInspectorCollection ), TwwInspectorItem, 'Items', TwwInspectorItemsProperty );
RegisterPropertyEditor( TypeInfo( TwwInspectorCollection ), TwwDataInspector, 'Items', TwwInspectorCollectionEditor );

RegisterComponentEditor( TwwCheckBox, TwwComponentEditor );
RegisterComponentEditor( TwwRadioGroup, TwwComponentEditor );
RegisterComponentEditor( TwwDBEdit, TwwComponentEditor );
RegisterComponentEditor( TwwDBComboDlg, TwwComponentEditor );
RegisterComponentEditor( TwwDBSpinEdit, TwwComponentEditor );
RegisterComponentEditor( TwwDBDateTimePicker, TwwComponentEditor );
RegisterComponentEditor( TwwKeyCombo, TwwComponentEditor );
RegisterComponentEditor( TwwIncrementalSearch, TwwComponentEditor );
RegisterComponentEditor( TwwMonthCalendar, TwwComponentEditor );
RegisterComponentEditor( TwwIntl, TwwComponentEditor );
RegisterComponentEditor( TwwFilterDialog, TwwComponentEditor );
RegisterComponentEditor( TwwLocateDialog, TwwComponentEditor );
RegisterComponentEditor( TwwMemoDialog, TwwComponentEditor );
RegisterComponentEditor( TwwImageCombo, TwwComponentEditor );
end;

end.
