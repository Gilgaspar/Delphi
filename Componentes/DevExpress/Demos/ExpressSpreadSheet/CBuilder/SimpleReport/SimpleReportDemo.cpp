//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <tchar.h>
//---------------------------------------------------------------------------
USEFORM("..\Common\ReportPreviewUnit.cpp", frmPreview);
USEFORM("..\Common\AboutDemoForm.cpp", formAboutDemo);
USEFORM("..\Common\BaseForm.cpp", fmBaseForm);
USEFORM("..\Common\ReportDesignerBaseForm.cpp", frmReportDesignerBase);
USEFORM("SimpleReportDemoMain.cpp", frmSimpleReport);
//---------------------------------------------------------------------------
int WINAPI _tWinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
	try
	{
		Application->Initialize();
		Application->MainFormOnTaskBar = true;
		Application->CreateForm(__classid(TfrmSimpleReport), &frmSimpleReport);
		Application->Run();
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	catch (...)
	{
		try
		{
			throw Exception("");
		}
		catch (Exception &exception)
		{
			Application->ShowException(&exception);
		}
	}
	return 0;
}
//---------------------------------------------------------------------------
