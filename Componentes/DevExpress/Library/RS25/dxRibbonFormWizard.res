        ��  ��                  K  p   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxBarApplicationMenu.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxBarApplicationMenu *dxBarApplicationMenu1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
private:	// User declarations
public:     // User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif

 p  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxBarApplicationMenu"
#pragma link "dxRibbon"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
�  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, 
  cxLookAndFeels, cxLookAndFeelPainters, cxClasses;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarApplicationMenu1: TdxBarApplicationMenu;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

end. �  \   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxBarApplicationMenu1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    CapitalizeTabCaptions = bDefault
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
  end
  object dxBarApplicationMenu1: TdxBarApplicationMenu
    BarManager = dxBarManager1
    Left = 536
    Top = 8
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
end  S  `   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 0 7 P R E V I E W       0          �PNG

   IHDR  h  n   5^��  R�IDATx���`e���g[z'!��A,`G9���Slgǆ���`?�;�{׳�Yγ""�B��SHB�����S6���}C&����$;ۓ��y�)X��DDDD�����zZ�	2�<.`�Kp��'w���-;�k��&��H�A��1+	/غ�ok�j���m�ԯ���_GB'o��g�f;b�-���������C��D�ȣ�q�9�*��إ�q�]��k��*���y�a��·x��1m�=��A�����@e�-��ǍEM3��M����AW���*q,T�|��Y����K	���:"-��J�˄]o�Ǡ�X���:��,��()^������o���9b������bFE��y�]�#��ϑ��8",�v��+���aq���1�/����/���Gc�qq$�H��qb����s�A]SB"�lq[/\q.�^|����r�?O���U��/��? ����cҮ!�|�4�!�I�fE?ͯ��Ϙ�y��`����������	���Lo��"��|֮\��� Gή��r�Ij��Cg�Y�3��D/�$p���*�A�1'fV�%m��|��K��+������#��D{C���
��J��>V���7�P8G�;[�C��2�����4�Z��^|��C�޿0�@�v�1�@{B�y[)О���4�r4��s�t5��;�DZ�i�p3b-y~ӓaD�j
a���ě��g &��r<��'XU��V�	|���םwc��9گ°�F(�}�-�6��Ic��yY%��"��#�*)�ˑX�-yS��0����.b���y����d~�	��#$���x�+�~1�1�NFz3��F%��o����7��Z��S	<���s��7��b@���#,�����G1���"��`$8�wBڳ��I��B�����A�lSOs(��3}�M�7�Ӕ���1��WL�m��~�L�#g�q:ڃ��<��`L��r<��g�@��s�����e��#F(�^t	FqR�Ӛ��s��l�/����w�8KfJ3m�f1�3#�[�әq�Y\����Y��cw�q�~�'�"u�������/Ϡ��9�e���c>�*�-X\��	���M\��]$���aD-��4����=ۿ�g4��G�->�Juݺ��gg�@���ϓ#h�';��_��/gƾn����p��c-��S��É��F��9��0���=ʌiNm�6��������M�����Kq��xv޲��G�+Ÿ]�߷O_�S���HSO3��A�:{���t�����A���V��[/����CNoΚ�-Vק#.���ذ[�4���I|4���
��������AfV&�s��������].���ki}L�kG�Y��8�y��,��d�Y�τF̒m쨩�m`����/F#Ό s��v8�_�"='FY�\)��+�=��#y昴b��� X�l�S�����s�X��:��N��g��,�GY?-ںiF�=x�4LmHt�#��;���������CuCK�9d�]5�r����1�M��������ey[��n�x��8�ҫQ�÷A�?��̠�Π8k��<���x����=���oe�Z�Y=]������e���Lc����yzS��4�����!;a�5W��g��Oy~�9R���ƒ��_B�^К��PW����Q��DYI>
󲐛����0m>�'B����[ZP���6Tc��f�Gi)��������r�f�3$4��Ĉ�iCGqE�ҴSđ�T�-�笓�,���bqf�ϡ~��#�jm�H�e�>��Aϭ���_��z��i�F_�NVB/�d`vu�Q��,i	�t����:h��-�,/=��v�=w���o4�D"� 'CA�`�y⽼)l����&h��;�H��6���,ϓ/n��sN���]���|�E��w�Ma*� 3�4C���X@zii�\�%(�N:u|P��$�l��y;�����1�y�̡�#q�s�N���k��'?�>(ФAE
v�s��-��m�U[]����鑇^�(��V��NE�,�15"�|������,[�	WnBN^!*+{#7'W\�}D���Y� %�e�:���kD�|ZGNe�f5�Ǚ���yD�i�3g{���@���R��Q�(Rڃ�N���|}Vo~����--nˊU�)!�!Rln�ƈZ���;�iq���jɎ�Yܗx�]�R�z�S���'ힻ�DU}��u����E��x��G1~��X_�%����櫯S�0��2���o���(�������+�Æ/?SO6�9��(}�QNmS��g����+�k�Ն&���CA�+g�98��z��t9#м�	F�y���o�;���_���@��ކ�:To؄���[^���,���eLU:"�\/`�}2���U�[�`�Z,XQ�>�*ѻw/�\��Q�|��M�,�f�s���Χ��'��W�ۈY�1�Na��taVS�j�9���׎@���<#=W�	�n:�X���\�߭H����刁b��4Ga�!`�u�����#-�3u�P�Uq�Zj�鰼�1�y����&�-��HV����^Z,���xL�������[�۹m�x��_����p��7F\~��W�[o��oE�^�����+o���>QO�h�8M�}��ʪz|]ժ��>���oi&N�8o�@l��D4�T�랸t��x�����qBMU��0����
��(A/�XGZ���_�"�����6b�/�����������ĵ~Z���T�*�5K��iX�,R�Y\&թ�x����z��8϶<b�4gȇ˩���q�Ծ7/]�+�(��4�o��H#i@���BG�B׏���V�]1�G���j����a~�~�ml��>��,�u�R���Mk�J�w@�hW_{���������ذfu��W\i�ޕ8�-����B<���p�x�������������nT��h�8����3��G
,�p��8u���]!n��������o�=���%?��۩�_��_�[�����w�!�>������R�7���}�X��=��0�m]�k��3�W����k��y�ںi�u�*>��:o��M_�Y�Y���p�5bh�R���1�<���H�3�~��>��'8l����s���a�퐑�4�7��)�F�V����ȧ[�F�S�1��h��L�<-�fLi:La�2M���6W��ѻ`ú5��=���8��ð���8s�x�ŷP.^�O3
�>���{�����T�������_�v;�u�P�2��z5����ZSW~���.�;wR�i�H�������j!�ߖ�eT-�P�:���b-�v�����߁2�λ W]s-���:^��PB+�x�x�簲g!���&^t�/]gy�W�?�{�V����o	�Ń���k��.�'�;���QYV�w��'�t~}�Q}w��&�V�
4���~v��Y�޾q����}ݳumZ�0��W���r}�+.�m
�YU�z�EzQ�޴	���0�9�Yj*��
Li:�����[�/Q�EN�ޯ��&�^[�_�Y�+SD�Pdff�ĭ�Y"(Q/_�%2]��T&�1��Π8k�-u�8�����i������q�s���?���$p]5"=d?<0�Elo��W�	��i��e�v	}2�����1�@��Q�P�m���s��|������9��.��:�	��iq��Ż,�e�L�Z]n�x���v�����#>G�M�>tb�����h��?�M�2mm������"�uەq����'N�o+�ʌ@+�����3w��C45�d�i_�en�p���^f%~���z�����a{���iW^�/�Ѷ��h��F�����@s���տ6v�!7�s�������ʺ�-R���ա�f��ܜ,�`ڃ��OA�s�
񵸳>��$���E~/�\.uk�éƙ���ש(�L�|«77�Ù?���'OF����"�˃O�l���.M�j"�!����*'(�����F�: ̬�;ì�
�(��h�3�Y��Q�)������N��2
?�v�˿N�\�@������_��vZ����Ǎ��M�k~��NXE��oMi��������h��g���㷺n�s ����k�ׯFьX$Uw	�D�>�j��O~6���'cɚꈁ����Q�X�Q���^hy�ex���p��yɺ���˿�胸�K⺭k��'�w��doq[��N�r<��z��n�[�2B,0j����[xnv��_����R�9Β���}��[�}mg�~}+M��CZ��!�-�>��������1i����&�@�rk�U�W`x�b������f�șC}�~�6�(�����1��4���V����2��@<��u�&ϣ��)��pa��Mx����s��PZ��hD�ߚ����=�/K�ߦF����7&c2G�Y~vQ�3�/;���c��?36
Lo�W>cMڃ3^A6\A{侻��o���G<
�>�zW��틉�_��/�uu�q�mw����ѵQ�貫q�XV/�]s�]8k�D��x�/�0����ӥ�^|�|�:�v�a���O�]7kS��r�8_��4ms�v>u��4�d��p�麧��M�n�}�����#0������?Ź���/�n��"������.^��'k����p��'i��׃-d���֊��j�F\�Ӟ��1�w��x\}�"�j��L��7�n��O�л_?��і�OEOh3������6Z�G���?����u[���h�|�|�ؽq�-�`ѫ�i�?hAs@;�˥E`c�~�����ۊ0�۾�w=��⃐�����K�� S�,�w����3��ɩ��Q�����[�oL.�"��֯G�ǋ��z��ͧ����t�����BimBf�G|d�Q�j�精;��*8E�e���a;������hniQS,+�H\�K�6���j�w�%�ݜ7��a�mh�{슜���Ѷ�f"�fq��ŨY2#cі�sz�}�Za��Ѳ8��7�p�ڑ����5��31�����ʀ:R�ѫ������^ě�%�p�	G��W�����Ϯ��x���eg�=
O����]q۴G1��1"��㬓����B/�l̾�bԁ��{��D^3����\�ӫ��a���&Cl���[�>"��05�>�(<.�����q���2�u�����1x�"���/>�Yc�P����&���������?����b�_�!��@�-]���QN����M��lp�\�R\2���n	�t�^.�s��$T������S���{ߏ�r���/�z�����ɷ݃%o�]n}O�ڨ��rS�ߩ�����V����[o*ڵx��!�m��P������3�^u5��dMb�k%֦�&�_�#���ۍ�69�e��L۩���oc=22<@k6}3u}���"7$���e���C�g`�x}pz2D��)�A��`Vr�43�%�C^��[����>թX~��g��#�cb�NHn���8Kv��V#fV�'�h��1D?o��-��S8�(�Kt�S��3O~���5j���(<�A�|�Nq�����p�1�c������/�ӟ��e��Ï>�+���������ʋ�ơG����'������ڈ�ᣂ�2����ѳ	g�����<��ܕ����z<v1R\�(�q����8��Q�O�^N˞x�v[C�mW����n{�E�~����b�Z�:u�sk���i�3�郊��M8s�i��f��׉>�x�C�WI.f聶pU�u�R�4y����8q_�v�T,����e��_Y`�g����\?N�8�p�%R���fڝ���4h^�ޫ_�+;y��[��
O�Y��u�#�-�-�֭Y��,�*KP�ت�y�>h����!^�k�������_���j�7ے����C�y܅��t#3�N�G����07��]��VVa�vGn^�:u��<�������æ8cN�%��X���%dIJ놅�v:�+��O�F}��yn�<� �q#�w��H�����/C�\8Q�c��d�������Z���p�8�$Zڀ�E,�[���KЫ�.���������P#i�c/�S�2��֠W����&�h'��Qǩ�In�p�-��h�f�`h����vhD��hi�P^��uU�/��:�6o��=5[Z�f�R�鱚��ea���S���l�yh��CM���O���6�>�H���-;��F�;�����{�C�;GP|ƨ�f��^�zcn�2s��g ~�܄�3?�=��i��O��ck.�u��I�4։�f���6���39��Z�Q��;Q�r\�<�Mͱ� }Mby]����!j?SD�O<}��b�H�iN�&� 7'M�zg���?j��,���	���p�HK8��Ҍw����f"�ΰ
�Dϟв�3�zb>g	.��L|cLT��l�,m�\�����;G��juw��S�r���о��wŹ_��;�:�8^��k"����ι�ru�o?����Ȗ4�O���i�b��S�J[����4�l�Q����A3�┧/r�SN��2����`�Ǝ���x	��8\\G��N�4}�N~?�0�:e���qGj#h��3Nq�G�o���Zʡ�¨���xΟ�!�^7�ƛ�`�v��C������['�aE��Ʒ����'�G햶���$�z¾8}�K�_�@?����oS��t;�A���n)0��A�29����;��[���+����_o���R=M�@[\�KF��:4T�È�����I+q�>�)����J[��[�v���YW����F�D��c��x�d����MsB;�G�ӽ�(��g<��6l'�dgv�����D�,S���5k���Zaz޴��řf����9ڏ�
	5ir�LhwM׶Δ˟z�|��wqǃO�o�����@�#N�w�o��z�����	���]�˞U�M�F�h���;�Q����x���X���K)�Wܗ�0d��4b��x����@3�"e��nuJ��}�����3o	j����:�ے:�!��[��3c�`��K��Z:G�RX?��e�P�p�������|��?}�u�W��7�
f�>��ߕ⏼0���j}��;�?l���b`_�r�L[j�i��t���8Q���O��ʹ��H��	�>�Z��}�a�{�(�����5���F�׍6x�����=�@[�z5ʲT�,TM6�v���3^�l�(~8>xg�Dѳ/ ��\g���7�>M�V�q#�/����2�]\�?����=
s0w�
��`5���^((,Ҧ9���)M�q�q^Ţ��53/Kt�����f�8b�7��c>�S�វ��cr�.���E��v�п�xwku?��D`y����%0b�D���~��okMn��d�D#�.��� J�D��c=���D"�ᬶ������j�,�@�%�x�"�<�D]Q���Y]�̩�j��mnDæU�ۅ������M�3/O{1�[i����z���^u	>��~�׋�#G����Ï��{�n�����Yh󶡰r��}��𩯄�O�h5�������B��Rx<��G���ca�S��G����F�"X�0�z���0����?���o~�c���G��S	9��S?��i��#�k�x�!Q��N0����d���#8�L������l�����G����5�g!���Ǯ���|1c�bY*Ӟ��!�2����u��y.�"� r�<!M�ہ��y?���������[�MH�Ԧ��R�>�ԬG�8_���#� �}�Y5�Z��GV<��ݸ	��=$b��������>�jjPz�$(-�X{�D�,X�&q�k�~���^�-(��������<P�����g?�A"�z��] �@��)M�tA%��"����Otd,�i�(�-��D}�q.K�L|��(��&���4#Ȝ�����^�-E�G���l����k!oJ��7���=�J�hZ�h�Ŵ&�7;�֚���t��E�&�Q��ձ�fu_�\,]=Ғ
4�/��f��Q�Æ�z46�i{�w���\ذr��nB��5��1d�h�"�d���B�.�Q|��h��36?�zL��%h[���Rl��:4���O�T^|хh��Μ����=��(�}���@ϒ|�������?�O߾�בt錳TF͢�Y��f	Mg��� r��n+h�f5��T�D�=�5Re9jrZ��_F���@�Q=��m=vXO-���F�,N��TF��/�D�� ��.߅"-�@����8r�p��P�OA�܊S��8�hܰm5�p1ʞy>h[�e6�x<�"�z�ǥԯל{!���%矣��6\3�_3g���ơn�hqd#�G�{�
"�2D���U�)��G��@VVv\���S�J�]w,]ә]5��&����)�N{�Z��#YN�Ƙ�{\�����æU��`g��u�N��LG�%�~Z�i�d�_��)��KI�ן�����y�gn�[DQ&232��.G[c-,Y�3�i�/�ĺ	���ᩨ@����{c�	���Ա(:�(�����˨�� ����m���3�y����� �hmmAK�W�� '#���?�7���؁֑�fa�{QN�0MG͒�Ό���V���h��Y�!���G
��SA~��~Ǝ8���ޘb�����NA�e��B�F�:z�3���H�G���u���O!cj1�Qc�Ѵ�iI�7_����1o�:lnhVw"���A�44������Qt���	4����'���Ij�5��#�~p���C�����s���i���K��\=�j��*��?��-m�hkiSG�J
r0|Ho�3�]��ȸM�� ��HeJ3ŨJd�-��o7�s�̈G˺�������J�ob?�d�s��A-N'{��j�Q�gz3]Ӟ�o7�z�)OyF9öiI��ofc�>X��k��%-#�\�5��5�ga<g��������>�-_	WQ��eh���^0�������3�onQ����q�8�d�.Z�f�-3CSk�l�[o��^��3^�8\��x���p��D��L۔&�G��1j��eR�k6�H�Me2̺�h�vtV��%����}V����c{KG��s�3��4���F�"��Q�i'v��g_�����t���q�V���+7ȣ�;��ɀ[ZZ��F~^��x�������]^DX��?`� s��Qr�٨}�y4|���]z��Q(�۩�FU�=����<��m@�R�V?����ϫ���bu���~��?�F�\�,�)�H�{p�DF�fdG�i�h��l����h��}��:�-��W��媻�|/w�1��ߡ��P���%���2�C,���_7o@N�=֮C���QW���#�4��m��]Z��|C����Y[�O��WܖC��a�����%8��#ѧ�7�Bv�mJ3��^p�")4�"\$�`Q,&2���cL��#�o"��6�w�D.�H�BV��:��y�j�<噖��<;J"�I�Gvcc��1M���％O��6����B������N��벍"�|p��p�]�zhm���h�Eaf6�_y_|_����n4�}���Ʀf�9
D�塥�>q{�h9Yn���w���-<�6�ؠ��b�����3��H�9�Hl�|z�@땫��L��M�%�t����8���u[Z�is#�.hnyL)/j��o����E��^G���px}���q����`�!�I�X�#����)hmk���U-S^���}�c��n8d;��v�'"""��aƽ���ۦ`]C��I�܋����,�}z���u��;�q�@q%?�-MX��w�6�$;�-A��i���֧U�Ga���h��Ц��{���Ug����6��Z�z΁�%��`9f�[�=���}����G��Ԃ��u�V����$i�<��>mjQi�:ty������-�Oi�V[nF��$�{:�Â���H�v������e����~DDD]@�M�����b�y��E=�S|"��183<u�����~�����p��߇�s~������2k��@�A��a;���V��'�\�,4���U\ƫ���(�Fv�Ͻ�9JJ˱�N;�������"�lY}=ޮ@�٭���?����]�ԧH���d.��AE��r$��
������_�0�or�3������l(�&�Dl���W��iÎ�*���A}ӕ�}q�=���.6W�������5���m��(��lk���� ��h)*Dky9����r��e�a���!3+-�mhikS7�J��PYV�Y?-���K��#л�/rr��@�D�劵�:�;���:l�MQ�)�T=�Ց�e~�nh���ѿ�$���u%h2v���9���(*�GM}�����"��n�:���b�uX�d֮Z�-[P[[�-[���s"� �CVe���;p�J��t�E���8���u���iK�s�aS�{�sl��P�nG��Ǔ�ݘ��q�jtH6�8	��8M]�t�$qA�o��v6�����Vc��y�/,��MDDԡ:,��Ǻ�+P�n��}�����V9u�P��+��]a�P��ɝ�ʨ[*Bm���hljT����H]����D�e��a���^�YNm�(������o|<^��v�e彑����Y�@��E<����u��>����0m=.G��qŔ��R���;ř&V���$n��OVcH�l��1�%$""��:$�$hr�ʥ���Z�?�2��h�*�;�6���G|v����J��0���+�p�O����W��&�L~/#MƕG\�Y��_��5j1l�.�����|���b2����E�q���~%p���c�Y�6�Q��
-��m�ѵD�78����o�:���ǫ1�W�hNn�KDD�X��$#������^D�櫑�v�s���V�wɯ�PGF�7g�:D��	�-�|j���@��&/_U�͜��k����PQ��EQ�6�S�^/�.��@KA�F�m�����A���Z�@#"�n-�@+�vY�@�d����`��_�\�ID� ��K}_����M�>�(������A+� �IF�O;��_����=�S�~��t>��G�5�a�vD�^�j����3����@��d�:�9�h�n'��DMڷ�L2=�Bz/|)�A}�������#h=3�_T���uWI���W������&"m��X��b�:�;鋲�j�ef�&/�PM{�6�E��~���Y�<���Ǻ��1��%�䛹(/-à!CQֳ����Ȍ�ޙ�_]���nj4��t?B_2�z���Lz�LI�2ifu$/��YA�_��v��Wc`�G4���D#"�������f[���4�@���$�D��Tc��h�R�]�*PѳX_'͡�T�A���1��4u]39���F�V���/KV���S��կO_uW%%����U���8�L��>�7h�E�h�',�5��!��3+�"G.��N9��I�e��b�,�8~ƈ˞Q��=����'�:��%����p�{~{.�����gS�����/1����±%�o1�;Vܿ���o���};��1-�{���Կ��q���R-��X��&""�́f��a���b�x�`l8��҂��b�e�ڴ�*K1�_9z��GQ�r��Q5��Ջ�-M�������X�l-~Y�999(/���(**An~233cn`e���\F����n|�0���ȁ��6D,;#,�"=�Q��
OMzw��c>��iV"���پ,��E
�j<u�Ӹ��P�yU�C�@�+m�hE�)Qweh���4ɘ�S�r�[�v�*l�ڄ���hnnA�&_��.䖝�YYY��+@Y�2#//_1���R����e��D�
4E	�` \p�E[~F����z��	�H���ˎ����tE}�C��>mm�+xY�ף�ˏӗWX�/c^-�����'h�끖�_��3'""�fL�v�V4���:��W[�����"��m�A��t��T�����QW����Df�eN�Kݡm*{���/�C3m���ޛv���V}�.��ŗ���C�Y ��p஧�������J���K��=%����1�6L���={�?���o��1Y�X]�=>�]���Nǋ�D�M>6|Y`�q��8�"�t阫&�ƽ���o0���빅�᧎��J}�}�����^��ŲA�2c���N�E��gu8~�x�v���y���9��Sv���1%�Ŵ��=�WX�,BGδ@s`n���@�������ϛ�����vWg��X?-�u��ů�֨!ueq���W�K�_������/�49��A7����{�\0\q��#��a�_��w�o�������k�1"\�$G��ſ�w��F�B*��z�!�e�jn�j��"���>�:�?�]�!Cj���o�Ǯ��{uF鷯�ս-(�BǼ��Yb��'n���Û���y�^�f6N�X�?�L��\>K�Ω�f���4Gp���tc�����hfJ���H��́v���m��4%tM��;��#`��o0DD������1���8FӔ���@�)2��p��cD�iˮ;V��4���gS��?N��{�t�˦�e��(�#��
羦]������.�.�G�J�G��,xY���v��B���4M.v��i����}�����u�.���t�[o�G�?g�-7��9i� ""��@��#h3�N	�β�M���ן�U8L���hr�g��$�@�.��n�@�#cD`�r(������&Y�\�,��e�%���$M2mJq��Zp�,p�}��S���]��^���ǨS�����:�d�\wܻXl�#��^����6��+E��)�5�(���ʈ���P
�v��ԇ����x�m�	q�X>��b�x�{Xt�ix��5�N�(����>h�u�⺦��P�E�@�f�Ѷ#�@K�PO]���6J���J]m@�h~S���6��}�|����i�`�g��:��|���ѱ�?�#��w�*��ǉH��=��#Ų���zk�$W{��*�|G_)G��W��n�K�?"�N�X[9_N;^"��-��=�N�o[�~���gq�r�c��-�',ѣ�5���_�g.S����Q� Ir�v^y�����Q�_���2��t;����v4�@s�/�5�������������!""�0F��	������{[��.���6��1�GA�$sئ��&K�
�^_ڏ��(i8Ap�9�MۊӍܼhA#"�&��@�h1GФd�ԅ-���+�@Ӷ�d�Q��@C�:h�@k��@ۊ��L����h��h�6@Zn>��9�IDD�W��Vh9�3�0���3Ř괘�t�0��nH�n#ڑ���Mvi�!k�����S��kn�����@��A3ZQ�@S����͇�kk����/�E�ӟ�/PB��*���(�4��4ǃy_�GY����uk���]�;�<���Mȯ���>9��f#(�!�l9J�S��Z���Y�ځ��M����`��f��e�U�T��$""ꮂ���%!렕�Zk��j����m"p���<7lW�����n���>��v�)N3Kd�1p�$&rK큶GВ�`�S��L7j��X��	KY/N�L���N��<���C�ǭ~o���C=�u�v�h�+c�̋oFsK+�W7`�r7*�3����*&�XHÊ�[�t��
�Ay��Ů�����:��k�Hy�㺣������<�����~6���{�8�>�\P�A}{ /'O�;w�#h�\Z����v�ES�z�f��DeY|Ӏ]Z'���ڃ�
����&�Zzu�'��o� Y货���<�� ��`L4ٙnl�܊���e	���@�d��Z��l�q�M�i��O���6��C�w�����#]:���v�Fw���V���d�z*�I���9�l)>]��d��r:�����vx��q�m!�A;��n�6n���x=�߷�6g?��0�҇����J��@K[=���g	�L�N�oϪ ��8�f�eh�S�!�A+���v�y�����o��>��jChQl+C�]�V����5L�zJ�����w��t������[�j[����6�w!^~�6-ж�On�W��z����*+�������)���~�:��}��쏤���OS����yw��=Q�!ɧh[yf3�N82�xOZ��|�2���Ґ@����\�_�U�?�2�:�J(��쏤���#q�bOS���ZTh�LޝU�����h�Cm`܁�wh˫q��f�-������-�}���$?q6�ki�q9�ʒ#h	���v�)���Z:�"|����%J'�>ŋOT,�]�έ������j�+��n�@h�G��d�]-�G�QZ[g?�.�Co�G�M�;N|����mwh���.�:��5��D��w�nh�QMn�Y��I"�~�v��&Z�h�.�qǉ�>K�Z�s�pg{D�U�oy>^�4�_�́���Z �����G�@kd�%���q��>M��3>Kq�����N-�>�NZOhOj��!d-,Ж�t�*м������
��q#�v�s�|.u-%h����ek�6��`��Z.m͎���]�y d���U�u��w�[��yr����ן�C�����)�~�f&m�)�ۧ�4Nq�Q����6�쀁Fi��������@���9Ձ@�'$Ф�"�v�+�����c�(��#h�q�Bi�_(J#�:Q�D��������V&�)�@A[�Yi�WR�h��S
oCKg?>���Hi�_(J#�:Q�d��s3��9U���)�(��_��CF�Vl��+�V0���8Q�Bh��.A����~|�9:�P��_(J�*Q:�Efed��jѷg.��ڦ���r�s�h��%�*hW�@ی�e��2Ј��|W%"�[�z
��h9"��T�875�/,�V�Zc��D��b�Q��@#";���Q���d��j�6�_�#h}́6WZ�h��uA4"��H�Ve���U�h!#hF�� m���#K�Z�@#"{c������7BMW:���.x�A%Y�����h�iJ��mm4"�#u��l|�}Mp���J�|U�[���	2�μ�V�a�D�U3Ј���gDdG��d�}%�����Ĵ�@���.�@[]h�2Ю���E�-f���S����ԠBڛz�U��=V��p���@kL�n��S�#�:�@[���ia����*Q2<"̾��hw�@�''��3z����>x#��L�@;C�=�8�FDDD�uM����3w��;�G�d��ʵ4�"Q�XZ�̂m^�@�H�qg\�%k�1��e�Vm���FDDD�%�{�b��*�.��v����@[�`
4�eaH� ���FDDD����CM=H�i�@=sBm�)��Wj�]�4"""�t�A�m	����́��!x+�=Ў��X�Vڟ����@#"""J�[A�U�����ms��̈��\h��m��82\h
����ƍ�����ᒻ���=��ھ\FZi�E����rh"�zr����(I�Rh�d�e�@���9u-��	
��2�B��=~\`��D�md�%�U&��@{@Zk��{d�C�b-(�F�@��@#"""J�e�����A��hy-Ў9�r��N4��%E���V^������>d��ls��8U���V0�h2Ј�����	�e����$K�ps�U�Z�G�e2�.����~QR�@�)-S�=x�)hh>Oqh��4遦���hh�d��.�CCg?6"""�.�Y����ބ�"���m�h���P��@��h�8Z�[�q"��3Ј���R!m���Bh��@�	[ڴ23��,�ڦ����8���Ma�%�A3�!5���H+�f#ϴ��n�_�@#"""J�@k�KZ�e(f����)Nh�]:����FDDD�gOh_U��0�@{��)hԷ�4�8��}�3K��D�]*���FDDD�GO������"�nBS�n6�V��o�3�"�(hDDDD�)�S7(����)���3�)/�[H��e��hhDDDD�p������4o�y���@���(h+D��>���%G��}�	=D������nBsH���h�]��D��b�%K�MZ��4-�@kh��X-�h0Ј�����ȍ�	4���؊3�!�r�Q:���7�%d-8�~��-��K�p*8��8R�Jh��ƃ�%C�S�_nD���E�=z�����#���y+κ}?h�6Ȗ�����`��AO-Њs�@{�.���.E��C�/u?hF����l,�U�冲�\5G�*m�hNQR��@���)0��l��
v�S�ￛ�y��A���/_�?��N�$h�-͵��FDDD�Y.�Q�%�^�v�MX^׾��4��s�hsd��>�@�@;��4n$@DDD����6�(ǅD��*�AG�3R�)�� �@s3Ј������e�z�9"�\h���$GЮ��v��MZ�yhDDDDI��a�WP�%��@��;G
4}[Nu��FDDD�V���h�(Zx����L2�h�D��/-��FDDD��6hߊ@+��S�IF��\h?��H`@�hE��`��E��HDDDDIi4���p���A�F�����M��h���Q�ZKs���������u��Ir�h��<��hDDDD�0-?Ӊ_i4Ɉ�]�m�i�ၶ�_*��@#"""J�h_Z�����#́����#	,�6Y�h�z��HDDDD�h-���!�~�2�&,�>����@�NA�����:h����@#"""J��Y���o$`D�e��7�@#"""J�@[��@X��S����ڵ"�;i�T끶��FDDD��ڬ/�#/Á�^�7#hh����mM�F��6JZ6����()-r#��&�HۭW�@3�8CG�hDDDD�i���'�m�l|����b-�Ɯt1�V�a�CD�ml���FDDD����j�!������@�F�F�[�y#��F���VӆQ"�r61Ј����4��״@[\��@X���7�"Z.����()M�M_�)Ќ��hDDDDi"⫩$8ЦS�hE�����Z%r�hDDDD	S-[�H�h�4�y��!����F���u���/ƺZ-��:��uI�%Yj��|����r�4�~Є=�-�4E��h��M��DDDD���l|��:�MߊhA��2����
�����~lDDDD]R}q�u�I��6[��46��!"�֫������$"""JF]�h�"�>�m�i7Ҟ�@�m��fڊ3h'�@�܆�탢Z��%��0sD�e9E���=�$#��mu�8��"h^5Њ7�t�c#"""�6�@[���S��"mϊ�@���8���hDDDDich��;�FD
4c����@� m��:Q2j�@���_S�IF�E4��J������Q�T���9��Z��nh��l�xhuz�mi���FDDD�%��z�@s�@{�h�ia������lHCD�]g
4�Z�og?6"""�.�:�5Ф�,M�3u#=�>�Bl��a�1}Pf�#ѻDD���'Dd3U9Z�e8����@[Xe�*�U��
ي�"�z6�:��uI��]�Mث2B���4�8h�F���3DDDDl�v�{h��f{�IF��#h{��yF��FDDD�>�M��h�VǗh�@ۤZyW� """JƆ,�|�N��{�a�h�H@�w�@�64h�@�[q�ja�%cC���OI@�#j����1Ќڱ"�����>ЪpN"""�$��p��wW��Э��F�u���?�����C��S���FDDD?X�3���/EqA�z$���<�9Դ���F�v� ���p��d��k�߇���\���\|��A�&ɺ
�oB6Z,�zm?h-͍p����W�����FDDD�֍�������Ffv>~�~�x�����h�>�&턋�mmEs�����~?w�AD��(ܨ���#'7Yٹ"�r�v{�ѫ�j��,� G���'��r�Dd>��^x�Z����0Ј��hDd'�Yp{2�r��p8��+�4�5��C�N�^�ć5�5_����hDd#N�Nf��������&�fh��3c#�CN��ُ�����[	4�ah+Ï$p=����(�,Mػ2J�G`���hB�$�@#"""�	��H4"""��3�8��U��I��FDDD�~��&�G��!	0Ј���:�U�I#hDDDD�#�@��b74"""���@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l�×D���@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6��������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a���$@DDDd34""""�a�������fhDDDD6í8����l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�a�������fhDDDD6��K"�nb�������f�#�&�}0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd3<'��0Ј���l��FDDDd34""""�a�������fhDDDD6�@#"""���0Ј���l��FDDDd34""""�I-Ю�6��FDDD�N)ZK�ޝ���������٩�����ُ��������+�=˫�)]�#S��hW_}}g?DDDD��$ׅG��	g�~ߘZ�=v�ͩ�W����Q�+�sb�˳q��#�x}[J���C��h�]qcg?DDDD�N���|�I'��֦h/N�5�@�x9����H�-O����?�iM�^���I\�����,_����3��U�ڛO�8�v���:�� """�tj�=�1��c��Ԧ8�~*�u�κprg?DDDD��O�K�'�t܁��{j#h��t{j�6��k:�� """�t;Vx�u�Ɵ����!�˾��C���O>_���{��h'���FDDD�Con��)�=�O�����.��K���/��<,٨���O-�Ɲ�@#"""�˃[f�?v|�K]�/w����aއ�hg�g�)�S��ᬿ���\��u��ɣ�n$pmg?DDDD�np�A�g9�ί�z���������f����>�Z��{����h�h�������n�z������Y�s6y}��>2�@?��FDDDԿ�7��������1��wT�~���6��E_=�Z�]|	�����O�h��>�a}J׵��q�)ڤ�hDDDD��L��%N:h>�~]в���~���c��~��R��.�����z�1��/q�;�?߭Z6�o���:f�Y��߿�Z�]q%������Ѝ�g|����^�|��>��Y�W��~Տ�N-Ю������G��>�5��o0��fyJ׵���R���1Ј����ܸ���8�����S����'�@w�����o���>����W�t]����:h����{r��Ha�9Kk���cZI�EY�ǩ$r{DDDDC�߁�f��)B��1B9�I��P���w����h۔����y<��T8�	;����ާ��[�����6G��?=���ޡ����҉�á'cu}g�E"""�m�����
�y��q�T,�?�2��w�rӔ[p�Qc��ށ��ξ�DDDDݛ�֬���7_�u�MƺU��6���n����	L�4	'�=���3Q��ҋ�c�=���8ԑ3�t˕�d�u�&"""����������z�,    IEND�B`�  �  p   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonBackstageView.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxRibbonBackstageView *dxRibbonBackstageView1;
	TdxRibbonBackstageViewTabSheet *dxRibbonBackstageViewTabSheet1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
	TdxRibbonBackstageViewGalleryControl *dxRibbonBackstageViewGalleryControl1;
	TcxLabel *cxLabel1;
	TdxRibbonBackstageViewGalleryGroup *dxRibbonBackstageViewGalleryControl1Group1;
	TdxSkinController *dxSkinController1;
      TdxRibbonBackstageViewGalleryItem *dxRibbonBackstageViewGalleryControl1Group1Item1;
private:	// User declarations
public:	// User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif
 �  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxRibbon"
#pragma link "dxRibbonForm"
#pragma link "dxRibbonBackstageView"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
  S  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonBackstageView1: TdxRibbonBackstageView;
    dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl;
    cxLabel1: TcxLabel;
    dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup;
    dxSkinController1: TdxSkinController;
    dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

end. |
  \   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxRibbonBackstageView1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    CapitalizeTabCaptions = bDefault
    Style = rs2010
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
  end
  object dxRibbonBackstageView1: TdxRibbonBackstageView
    Left = 8
    Top = 166
    Width = 577
    Height = 266
    Ribbon = dxRibbon1
    object dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet
      Active = True
      Caption = 'Recents'
      object dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl
        Left = 12
        Top = 44
        Width = 300
        Height = 208
        Anchors = [akLeft, akTop, akBottom]
        AutoSizeMode = asNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.ColumnCount = 1
        OptionsView.Item.Text.AlignHorz = taLeftJustify
        OptionsView.Item.Text.AlignVert = vaCenter
        OptionsView.Item.Text.Position = posRight
        OptionsView.Item.PinMode = bgipmButton
        Ribbon = dxRibbon1
        object dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup
          ShowCaption = False
          object dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem
            Caption = 'New Item'
            Description = 'New Item Description'
          end
        end
      end
      object cxLabel1: TcxLabel
        Left = 12
        Top = 12
        AutoSize = False
        Caption = 'Recent Documents'
        ParentFont = False
        Style.Font.Height = -16
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.LineOptions.Alignment = cxllaBottom
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 26
        Width = 300
      end
    end
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
  object dxSkinController1: TdxSkinController
    Left = 536
    Top = 8
    NativeStyle = False
    SkinName = %SkinName%
  end
end:L  `   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 0 P R E V I E W       0          �PNG

   IHDR  h  n   5^��  LIDATx���|�d��񟓴�Jt0[6��2n0�e��2��m�ҽ�n�R�^���1�Xw���{tAwӝ���GdY��r����E�-ɲ���׿�;w�aH�ID݉X�7o"�z)   ��H�u/������?ia(e�
f�E*g��[��'�
�^kb���+�:�G���Մ���n
��*�������oQhu�kt^��5�f�/�ώd�̩$�A���]�x��λ��ί�׺{� 9o��V��KT <�����g_���{@��f�TF#)A-y��6;�f̔z�*�6�l�b�刺ba?���χ�-��}���\��S�'^��4�e9��I�o�u�]G����2^g9LP�v#6χ��;�簌F�P�n��4���cL$��t��0��ܴq�O����+�58e[�mˢ2p���e��*P$�Q�F%Er��{�|3��$<46_�����%Ce�7_YÊ#�۩8����ğS�'��z������R��W֌��Sl�F|�h��*>��$������;o'CF��zEVliQjȓ�.���ɒ��~;��٨�C�׉�Y�,� ���-�:�4&�:h��I��HM^�%�醶@�g��k]��~����� ��$�6�~Ƕ�ٶ�W�z9�z�%�#r�,��5��d;6i���2����#����j�6-�2h�0��ګd�f�t9�F̀v�|���dm���Z��\�$��"eي��&CZQr�=�I2�����Mu���6j��Pf�G'��،�dxSJ;� �ǌ�[�yE��kY*��'�+��Z�����[a�}z����,Y�Fsg^oؠj'[誙�t�{�8sU�H�e^��/G0*t0�^7�m�e��i�k�,.SЉ�>��/`�B��m\��t�вUwu������kE-� �7�-WZsF5�m�m�:B��w�l�в�8èR34�;�\x�y+h����L}�U|x��r�%C���O�a�@V��ćIİU�╶��$��
f�;�iVDS]�"�#1�f�ڝ�+gj�Hu`���o�]4v����kɀ��o�C���|���z��a�8T9����5��<��*�P����*�&���f٪b�*jY�33.�F0�T��t_'�R8�Ꝟ�_�˰l�*�c��c������*#.�����V��g��ڍ�%�i�����2�6{Z�}7{V�ө�mc�a�G��+g�z�������F#r����y�-��_O����xR���{�H�z��'��u|�y|�%r�!���X|ߔ��%���3f�}����~�-\����i-}v�F2����rk�3i���Vr���YIҢ񥵪e�Ԑf�U�$~���Ȑq#���������[o�'ռ��;����<+E:� �����h��k�4v�O��|f8�|�͓�*f٪^^���Rm�!�i�M�y����9NT͜�����c���EnK��\�Z�����v�+4f|]���6/�q~�Y�[Qә$[P�G��A!*jY��C����W�4�F�#�gL��M���	�&�H����~3��{��^�%m
r�O�*w�zEֹ�i/�7R&Μ��ZM�ȓ����ɚO>H	[Ŏ�����X�����O��׿��n�cU��k_���۾L�]�V��*k�����u��rC�=b�@��!-�b;{�f���VY3�5���7Z�|��)M-S�fQ9`��c��ߕ�W����nD�?�}��x����y<�kF�o�e:?U3�`�m>F��:�g�0xU�<�=�s]�+��-�jX�L{>u��3����d8���'L�O�.�P��Zf��M��Ncy݂e�<2�B�ױO�|�a��Sw� *j:��\u��i�l�=Z}�2UԼb����$N5f�L�<IV�S��U�m馬qy�ȹ�%+֦wjW�f��VJ<v}�xH�7`���8�u�f�k=3�������;)���ɨd��f�U�)�~O��J�]�An�q���G�m��¤
g�_8Th�Dzo�ʪ�E��tU�>i�FlI�8u[��^2t��������[�=����O�[�o���qQ�4m���P��"*���h`]�����*�梮6if���x���^͙��F@��$��=t��`V�fL�����^�J4�Ù
fE���մL�)S�I�1C�BN��:�`�������������}^ɐ��ٶ>���Z�i4Zkt�ZrXDo>^M�n��^7���ܛ=;�m�	2q�8Y�~S�|r�<�E�RY��r��gʲ5�'1? �]1Wn�a��\6ֵ��}����]^*"���s�.�c���cN4sF��m��D��_�&�D�K<'�h���5���r�����R��~#�6���N��͛��m4�h��%BZe|�F�(%����V@����R��CK3�u�1��Tm�6�ҤQY�l�T,^l�H���q���|��6�Hæ���|� u�rf�0�O��qϫ��j2�ʳb�Nu��b0ӞO�l�,r���a�A-Ӷr���8�p��2}��I����<^'g�^�X0j��7-t�F�TE-�4~����Aͫ���4�K��3��4��M�$�ƌ�U�/��V�����Ě�푇�Yg������|��2k�(����W�%�g?f��t�������~rt�A��ݷ�a��I\�"Њl-���z&�z�ߖ���WW�ls�4|��ѲD���T�3��YԺo��J#v[��38��\��{w�a��}o��v4�>���+�Y�&���e�K��?J��8� �w�*��E�];�(m)%�ڦ��\���
�c+h���*����>���N�yޯ���'Ȧ̔a�0�߄�4���W�T0+.��[{���܆{5����
�3Mݞ�7@�Uˬ[#��Ĉ5o�5����堖2�G5��ٚ>��晵o���jZ��Q�8i����R�������W_���"٨�۪m{9��a��۷j&O<�}����}�:J=��2q�@����˱}O�M`�_�`�����q���Z�lg��?�$G_>F����g^��D�fq�a=.6?�%�y��}������|^�J&ėA}�'M�'{nY.�lY*��*3pEc�����*��VYs��b��*s�OZe4�7-�M�]?V�͜&���:��ݸFoY)�o�%�Jf��T�[h�I'J��%�lkiдez%��桮6i�����@�`����)S.CE�O���|��3ղt�o����UW�J�b�lݚ�r���_�.N>��G��C�8J���9��e�#�H��;�IG$7����{7k{��y��^�R�y�\��i�n+hi�]ۀL���5���=p/�ն�c�ϕs�Ǿ��6y�l��Y4�\�D@K�gdn��������q�i2�,��2�3c��L�ӂZ��*�M�<M.��_��뚌�x�嚹��nSV��"G���u�k�L�z�q9���囅�]���G����ǳ��%};�+3jx���+n��NM�e#�������%'ɑG��O>��2���cC+����덶�/l%�F�K.o�?�
�{n�Uް�i*����hU���J��*�0���i�R�H�	��<A�Ϛ&�.,�?����.�F*��VZ�t��6k�9��d�EJ�.]�Q�����$k�Ȍo���Q�w��g�&M��L�n�%c�˷)3ˁ*�j��Yf��M��4�U��x@;�妻����&�x�y>�"y��O�e�V�٭Z�R�?� ��3���-�}��%��{����.��hjU T���O��9�-�e�g$�k�*�o�MU-����lr짖OӧW����?[ߴl' t*�:m���Ų���^~�!�8~P�mi���I��Ou]�����駞�3��&��Z���{X���SPj�y��-G�_�6�v�k�>��u����l'$�0+�����H�W��My�a{�����l�Y�UUl�5wʰ�$Cڬ97�ɟ7-VӬlTYUi�5UA�0�UF���BZe�~�rꄁ�G+�fM�g^�_@S;�M��J媅�h�<�ص�4궇�l��[���������H�|�4;�0�����x�
�0�ri�n;iަ�ַ����d����ˣ�g���w}�m���}�������CV��3����Lق�*f����_}B�=�%Z�#�$�ܳ@�0ښ�f;� �����{&�JU�;Hn��@v3�ۛ�U@;�o�������"���,�e�gJ-�Z�޽��^ ���M�Xס̲_q6��YU4~k�h�t��u5YQ��D������2/rw����6c�l9��eᲵ���'��f�1w�rDo��ֶUSy�駥o�SҚ8����K�?"��?C�n��~���Tתd��M�agɑ�ɏ�����լib�b��Y� ��n*��E�(�^.p�u_-�7�'�F��g�\.��lk�
mW^}����T�TU�JUE����*�K�������~%������ڶ�#C�M�g��*���ؙ,��#�Z�X:-gM��o'�~/M�����kRܦ�5m"�>�Tʎ=J~>�Lٲb��0g�4�z��^�Nذ�ӌ�Ɲ�mV�t���	)յ2�-�W��Ty�Hes:�ֲ���:��1�cg��7R{@�5oV��p�ګ/>/7_w�,x�Yٸq�}؁r��:t�$G�<P��'#_*k׮����J�����v�ꆌ'����M�u�\t� �o����_z$�kc��?#��:�j���z�z�̙:�7a��r�%�S�������Or�=%Z�S�W�"'yprުy�χ���^�t�����<��?��N�ˇ��q�/�����g��o����Z�3m����Ғ-��/�z���ÆT@���PE-k2۝�}�#]Õ�r�:5�=g��{�E�p�ェ�'|��k��ץZ��M���w<�u�
h{�i9����b�>o�|������i��6;v�����~�^u���ϯ��<k��d�x���X��$>���+�Rп*�ɗUM��hעur@�ZykK3���q�lM�ý{d�\��
gQ3��>hfJ��J����UY͜E�~ �kQ[M5uv:���2I��aYn�~���J���.�n����I��E����K�=v�6#�ɒAå��)RԼL�}��>�������eٹ�A�7SPB�
�|3��]�f^A&Ȫ�Wgf�>m��T��_�9!�T՝�#� �o��`�j�f@;�{�/Kb����u�\���T�L���{H���Q�أ���n��c���}+}{+}�3�u����[����ﾑ3O>^�{�i��v>`o������Ï4��'r�9n~|\���-���%W�p����e������XZ�l[�H���a��^FE��� ޿�̽A��(�"�g��G�yw�$����?p���l��.��˱����Oݛ��*�|�L4������1���3o|,e-Z�Z�V]�D�͠��!ȦϜ������5��f�D5M]b޵�˩��&��V��(�2e\}�mަEy�o��)�O����gV���u�&�ք~rX��e�[�Z�͖���r������}��7��.^�0�g�D�p1b'�;��LU�TSg�yc�
Z�
mQ�_�u�
h��$*hR�@���6z�<��b�m�����H�~���^k��_~%��_�n�x����gH��H�Yr����b�:X*��$�t?0�D�������No��v��o�����I�o��Vh�Z��9��e�hYF�8�)R�lgh:����ֻן������~�&Ͻ���j��
F)4�������_(Ǟ�[z�Z���K.��N�#;u���y>���ҲU,tp�c����rb�����*c��J�Ar��)s�5�@��s�����:�a�y}����6G5�}����L'����f�K�#ч�z��+��V���9ϕ+c��k�X ]w�l���n����Z>��9�WEM7�9��L��C��w͗��8\6T50���:D�����?''�t����<�m��z~K�ޜ<P�w�,}�_) ub@��l��y3�F��e6b����f����!��5U@�����z?�3Z���Ъ�B��M^���e�l��d���r��_��kS+�Z�������������a�T)j�L6}�4?�$)�oR�sW�T}������4V�w\o�,_'+o�^�4i!�v���tw����/�T��k���?�X�v�ҼY�'h5��膊��I������kށ�BU�8�#��L�8mz?��x�ͪ��.��x�����ի嘞�;��c̀�蛶i�&9��q2�ܧ��u��Y!o���3�'��N��qh���d�]���m�=��B�j�T�)q2@��vR|x"��eTո�&O��U|��.�P�9�w���;H�]�%��ٯ�d��-V���'�hV�|5��Z�J]�&"����l^�F��!��=U&ސ9��w_���j�@��������+���i)}�k5m o�"�^p�,�����h�D�D0S�ma-�O����R$�P2b�LUϬs���Ye�:hUU��Y�"1,j��i���l�K�����cv���l�o���\z�|+�Y�_׀�UZ�����-�67�*�[����v���?�Nh~JoYu�=b�;����-�}/*;W�!#M�M��S.i��u?�B�
gͶ	I83
�<�h^�Q5�鸟O8���臿�i΄�?)��ߪpf����6��QZ'	���V�|ln��!�С��TeL5c���f &�/,_|��\t����K�[�?�q���ŗ�����W�4C����M���qoX�x�*�*c��A�ƻS�ִ��h�চ>���6���h����l��fͻW�ąD@���.�춧>WY��к�-�$���K�����?!����,�5_��i�J����5���m:w�}{t��ښ�E#��b&*��9�XY��*�g���ar��1�a��d%��R�jJq$�2�k�b_��C�Ԭۨ-��G�F�g��xx3b!�*���
%e�����?�cw�*W<��7m#�+l�;�о]�˨زY�|�_�N�O�&��J���|�$YӲ�t�}_)mX�����^n���g�����5yu��Q���29��f;����1����f?�����nU@�.���d԰�o�F^���rݭ�ȩ'��B�j�T��>�����5��}N=�H3@�2��:�?���ָ{}Vzq�u_��Ie�[X/{ KT�Vǃ؍��i$N�I\g�G@S�I�������wS�2��/��h�0��#�$7���b�䣪�8��E���-�� Y��=���L�Q���e^i���D]V�R��T��}&���;Y�bYn뮹y"5�.o��e���:�)~����������`{T��;���Ę
\�R���UVJee������"v��D�}�_E�fsX�5�z�pJ����m��ɉ�o�u�%R����[9~�)[@S������ٻ���U����̐V�:�
gK�9Cm��l�eO�n�ݪ�p��Q�4��Qq�	g:?{�5d��+���\�Y��Ќ"�f�y�"�is�맖\�c�;OX3l�Ŷ�b{,�i���~��k���O�(� �?#9<I��G��XQ�Q�S�kUIkff�����弍j�̿b�;4�e�m�r�H�����Д/�{MV,�F��Fe��!%}"E�X2���n{ȏ(�7�����88m'��V����S���M�s�׼=�$���ڲ�Sw�k�)�c_��~��+��o���o�[�.�ݳ$ݖ3��_r4�mJ�LR�gp����PM����vB@��N����I�-[A4�ӲUs�: �L�{Ҵ/h��Οx�+瀦��凲��Oe��r�l�(ƢE��N�m�H��J�={��{���� ;�|x�
?[7��f��L#(fꀜ���ke�f�ps~�h�&�u���\�������f��p�ew��+�e�qxF�?sm���<N���O���W5Og[��h��� ��uW�sn�Ր\����Ԇ۴q�������7_��%���ޭ;u����*]v�&M�6��q���L�bn�L�^U3��M�:͎��M3T�m����)�%ƹ�w{���*�>CP�>����5��~ �`V��n�̱�6>S1í�i>���u+`�T�2N_S!-��3���;CY�e\.'��\�=�+�?!�N��ek���W�t�F�>�~f�h��A3f�U��_��%�#}YS�3��tk�ts�Y��������ۤ͛����]WIs�f~��3��[�SM�4���^���lt��_��f��t�f�3|�Sas�>�>fAl'�_�
��/]�����y�Kb�J��
�J���l}�܆�鷖��4�k9���j��z&�/\����9u����9�%�^�,q�$�����yh��|�+_��Lź����ʩ�u}o�K�[���a�������k{�Qp�N�#��H�]!��+���Y��痷B��䁔���� .M�i'�����25kڃYQ���3I���`;;�/��Y��g��y>7[Ӥ��)�}4�jo� f��-\�B 3*i�T͟~��D�	��T}�Lմ\O|�yh�g��`�iγ73�\�9�h.����B��6uzn��&꧿Y�U3��Agk��Sa˶N:͙4e�Cm4}f;VJ�L��4m\�7��B~ԩ���%ui�L2�v����+����ߙ#���4g��lV�U�,���������:�pS�@X�X짹M�O͐��ڕ1��c�,�4�Y��ri��DӦ����-��fWE�P�vK�J[J�f�#���p�9���\�cFZ!�G3�����N�<�` �
��TP����1�����Q�jZ��e}!�Hi�t���Ù�Z�X���ثЊ�G~p��|��D����f*�H�2)��)��)���sZ�&���,�S��6�x�ꖡ1QA�2I] ~k
pbDcDD�yM�^���i���ב~i^[H�g�&O��дZ��.��k��]K�t�b�ه��U����R��$ip��i�W�Y'?-�E~Y�R**�rxRII��٪�tܺ�4oެ��oH��2��4��r�[V�iq����
gi�4�she󶓶)mn.Nee�+�U���D6�-��2脟�&���$�]�o/[oռ��KW��/�E6W�n��Xۋ �2r���ʖ�KbE2<�	`��I'+hQ�*"��g�{�3[S�g%M���i��sZK��Z�l�(���~��D�4�E�����WU��o�_Oz�i�\*��Q)wjb+x�FM}���ep;弤Hd�����_����������3���2�j6�hLc�2�K����iiQ�*Zԣ�fj:���4Y�^dsEݿ����f@k�T=�V���}��}�m9��d��G�=�"����c{�l����u2���1ǈgz�1<��n[�"sލ�?�=ϼ-���k �	[ӧ�fO��ȡ��� ���9q�u,�ϒ��`&��b��Q#}��zh:���bmS�͐"�,�&��)j��D�It�*���H�~}IJ6�(�תTphhO�KٌUi����1��-��O�0|�����i��U��%�������:��x�?X��o�#!���y9_86�뭹��9��/���=�Hk��ZIs�(�m���5*�m��ss��e�nӤA�����J6,]"�M�$Ҥ���o'ѪJ���ai��UҰjYp[[5q6*iQМ�~�h� *\��{�m�e#���=�����m��{��oK/�ʺ0���U���lU;�g���?���_�o��L΀�U��U�h�Ж邵�W+��!-T@;�Y���� )�u�D�d���I�koJsտ͊�)oZ*�#���?�A���H��J��_�����u��%�=E@�w@;��4 �-�6{�M�υs�*w���UM��Գ7����VS��7B��Zր�x�h���66�E��z�l�u�Do�C��.O�_�|}�:����Β�&���7H��/�o�D@k��
h-f��'_z[�6�F���Kce��¼����2��<�Jn�����f@��hGJ@P��Ot�=�&��Ǧ�|�!���4��\�,�M��&.�M�+i���3�ٟ�h���t�%�eقQ�H~��v��I��̑���𴲬��^&M׿*��2��W�����Ac3��*�ZK�����βZ��z�r;K�c\$���s��=�3�ㄉ�"r�Ў!��O
��]���6e:���)�\~����5����/Pk$Cً/�$O?��׻���p׾h)?��e�\���v�
hk5�w��U%����n���OK�>��;�`mcK�T�^#�eM� U,U+WI�aC)n�R6~��,9�0��~_�eQ?ia��ck�w�H����u�jV�e6T@;�dS�Kw>#{@]�n��7x�\1~�tپS�dj|����_�'��v�(�C�n�ݏ�dห��C�]���Ɯ���9�q9�����>�Sn�{��`�W�o�5�e��/�=g��s�s�_�����@��p�u����Z1��Ҩ$"�?��ۓ���)x�]@�	˷������>$�"å
V݄i�/�$O=���z�M�o�%r��>��'
x-SZ@�&�Iɀ�:^A���?��:��ҳdi�i�f�8�p�	�f�@+�IQ�l|����wҢ�)�˘	Rv���p�d���&�|�pٶ��j<��2�ě8��ֳ�/�����h��;n��+�Ȥ+���)͛5IN�r�h�͐<x�u���6�[�49_�����uɑL˾�|�A��I�C@;�0 x��X��^����:�No�������/{����,�
i'���z�y�/]|�5�>h�+���\GE�_2L֭�I�κRZ�}�4;����{�4�vi3j����ni���KI�vR�f+Y�o�l��c�h�D�:X�j���Wr{�?�Hz�r^aֺZ�d��f�J��c/��h3�U��*��6�d�̐+�]2�3Q��b��q��М�'�1CNb:g@���-��k��q�w�ײ�繭���nke�b3���m9�[w ��Ϲ���y43���nM��|-�vkU�p����(O:�Y�
iǨ�v��5Вgqn�-r�Ȳ=�yu�H�\�V�^{�К�~?Y:d���J�9�e�ɖ����{�UYr�s��Rդ�|}�%Ҭ�+9��ccddn����.�hN���t3�m��Og�i��˧ɚ��2��>��k����w?&���vBO�Y���^�)�/���J����k�^nf��d�iۦ�u��3��)s��=~�ּa�m�sy�ۮTM�{&�w��+n��5��<?-a�j}*���<�>'���0KK"��N<����(h0	��r��H �Ng"�Ǵ��<I���y��UΜ���pW�ąj�/	��bw��r�TT�.�M��h�/�LJw�E:�q��:a��<�\�Z����,�|�l|�}�j^&?�)M��~�wd�#���O=��l<Q.m\�#f@�{��f@s��o'6�\8^���
A�~E������	VȺt�\�9����}��8s������%�>h�P��W"��1����q���e��~^��?O��>Ě�۸��z��TT�c�k�=O�;���5U8�t՝��3��U4�8��V��uT�w͔��M0�a��ִC�i�V���}F�����GN:�� �*t3h^��u!���?��&�mM���{��N�����.�[�:-��/����gK�fp9���>X�k֊���Ǟ��B��<D�|������,�{�lh��l�4Nʖ̕���ri�2u����������Ih��hG��J�����T ����d������ -|���O��W�mW���۪X*Ȩm3j��r׼�iI�g��~�|����Ǯ;f��a�f��zl�O[��9��-8%���o��!��sb�2�:L[�=Ui��������<_Ǖ��`�J�̀��w�7 �A5-��������8Op^��Y���ȃ�4'��+=;\^z�%y��0���?n��(�u��D<Nq���oq�7ZE��4gct������|�l��{�Cix�|�4hh�Ϩ�c�)j��
k���։E�K�ڶ�"�w�"��^,mJulE����1^���d��k��K@{�h��mK�.�w���zŚϩ��K�����C&]'g��+-h���d@S���J��ٷK��NHh��M�^��}D �����O/ )�jZ>��Ā�^/����N���6�GV�5Т���6���Z�l0ZeU�%�w-љ\-�kkJ��>������_fقY��}e噧K��d��W_��?�����h����W��$���o˩�����K����Ś8U {(��9���9kt?ck�'S��,y����h�\��X9����0^�۸;��N6�M�/�7�6�s��m��\��-T����_�ySƛ1����\�d������j*�=d��	h P����_w�c�0�g�&�h��fj��Sp��u���-b��P-".A̻r��_���<���Ҫ������R���Qk��0%%R����#ԩ�K�Эo��M֥n9�6�P���n�ͣ{��ɀ��h���_*ݮ��a����O��WX�/;�����{2e��r�=�$��������od���1WY!�k<���0ǩ���9*<�����s������Q�*����m�T���u_�sM���륹jv�vBJ s4�_��{�7��0�N���.������Wb����e�Pz콫4k�X_x���m��ｋ5��딚���3�?��;rʑ4 J ��@���(l���~��W�r�%�9���r��������Q͎�є���܇�|[y��Ҥ�V�y�Bi��7���8��Q����];���?ʒ����j���!٦Պ��Z)sh�MQ�u&�GW��.�A���o��@s��?�e�_A;�� ��L2�B9�[㉎��w�L���Ueh��g�/���R"����vV@s3M=^�z+���^�|C'Y�~�l\�D*֭��ˤ�][iܨD�n����[Ү��f�����̀f44�#��Õ�M]���V��?��v jZ�A+M�Ni�L$C3�*Z�_r��kw�$��fjqE<����,g{VV��˶�/��o7�u��y�b٥�&٥�Rپ�Z�ؕX��;��Z4�JX���}�T@���i��xV�W��_�?������av��5~�!!��ٗ� ��|j*H�v`K;A@R�bɊYT/�%�g�Km��h��h�S[I��*6WB�̳O���8|m5��6ފ�Q�u��bY��J�xUz��Ͻ-}���*U�����:�8גW���>��洏���uAa @��;@�1ݧ�^�~��Y=���Y�h�Q=�L��lwc��yP���\Ѩ�e�.Z��sxni'�<v��{�EE�h�J����o<�>|�����[�~~�Bcv�j��E�M�9�<_�6CU�S���^zW� ���.K�v,����[5-{@KT�R���{@s!�6�2)Ь럹T��3��'M܇;�����i�fS������6sS�/+���_.���J8K\�Skv~�^{��o���tߵ��ߪym/ ����	�{%-��H	Y��a������WY�>}��ڊ��Q���瞖ϖ������ک��WW�жUm/
�X�l�����ɷ�k{Q
�.E�P~�ɵ�_�E���CB�oȥ�RM,Vm/���;�QG'�:BZ��M���̐�c&�uWL��u   �W��(W͚&��S�k@�s!��&�_HQׅ��<�V(�z�Z��\���M�ɀ6����=
�= �+�F�4��=�}���
  @a�g@��
  @��[A#��`5q��`Y�m��m����G_ M�Sk{�'	 x��P ��;,-»J�`�8koM u���qP��ѓh5�����q E�xW�P8
��*h��h�̡�   HCFM"�  �I�mk3�� �  N�+̀�D7�%bZ�D@�M@�F� u	��4���-QAKl:׀��-N���4.����H�Ba�c���)MQ�ʴ���[�*��#�  j��IiMى�  P;hSj{�~I ���A'
�ݕ��c&��L�٘7�
�6~�B�G�"$4l�3�h�/	�K��:hM̀6v�\=�
�>vx(vx P��Ќx����B@��$�T�->h_�����B@��dX����ju�  � ��N��w�/TK@�B�Fa �+�9���]�����Pgq�%����vZ�� ��p�-�KO���k{�� ��P"hu�c@K�$@@B��(��q���J��qS��$�-�%�k��v�L�8u��C�p�G�=
����c��T���.im��$��4��ݡPh{,
�+ɀ�8I�K+�I+]~I�
h�k{�ޗR ?M�����4b�䴀�tm�RA��:�fL��u   �WF��UЖ8Zπf�NP�J  @�F&�㧞�ڷ*��3��!���!h\ �{@K���;;�4�n:N4q^9}rm�C��q@]��I�㠶��&�ĦKh�9��Tm-��4�x PߌhKgq����[-���+�F@���-�)��U���}�X@�b���^�7-B@C�p}=����D@�e}��[:*h�����h�h��ˍp�	
�7�ƁPר	Sd����O�j;d
h��+  �0FM��hJ"�����'?�J-v�khsh   �h�l��B��-\Z�y�����6}�   �h��
���3%�}dh��ն3�PZ���.��
�㠎����sb'	�?�ۥ���>h��h4q��@]@@C�p�hS̀�,&N4ܮ�#����ֶI�h	h���D�xW!h\���[�4��3�yT���YA�qub��6m�Ɔ�fO�X��P���C�����d��x@�`�g�
������թ��Pm��	4_h(��"h�P(��5ڼ9Ӭ��$>��:�OkRm��,�?�3�$4
�A-c'�ڲ�����r�~gh?��:Q�M��6kʄ�^����@���CA��B�8�J���A�t����4%�qUm�	2���oL u	A�8�k�
hWL��&δ���Z#����"��7&������qԕh+�$`n�Ne.-A�۪Q"���~�Ac�����B�8�cܤ�r���mL�4���kS�8[���6k� ��Wu�V�A}�&�ڊ�I���������4bm�
h�i�j�
R�����ɵ��f;I�c3C�r4�V*��$�  m���r��d������dqy���+-�m|m���Ё��ڢj{)Pﰿ�5~J,��J�x�CS[@��hK�S/T۲Ԑ�̀6}4mTvQ0��4�( ���	�g�u*�m��6_{g@[�.�,ΖH@��ԢP��'��� �iS�z�6��w�5q�_֥Z��m�
h4q�PBC�� �~�0%�Vo��R�
h�RZ46ֈe_+���H�7� ��P�P8���V@��M�H�k"���D@�+�*he4m��P4E� "Tf��+m�N��{�y�mcG@[��:��mۼ�!���㍉��QGQ tA�7a���*G@3�Q����Om-�]�h@x��C�H�(�WZ&���x��Gr+g@[�!���YC.Um"�m��4�
����If@��h�[R��n�h+6�6q&�T��4"
����ISg&��Өڞɀ��{��QAkj�K�Ѐp`����P(�t��v�ܩ��QAk���V9Z�D@�0��ס�`�.�8��qԖh���=�}f�՛RI�I�!�O�)4m\��Ñ��]��q�7i�L�y�4Y_����U4R��Գ8����6���2vx(���J_,�M���ǉm׼4��V�KJc�o�1Q(GR�
������cmC<��Ϥ�X�5t�5�R����������ᝉ�q EAp�Z W��6y�,��j[@�kn�=�m�#�5�������:�HQ(�� �^�2=�6:ZYƀ��	h��P(4 �W�Z����
h��Z�f�I���F�6
�Nh;,
�+)-R��L	h����%�A�7�ņ�6�
  @�T@���i��2> ����TЬ�%��G�qI�:�����<:s#x:s� "�5M��8�S}���`�\���ߓoV�nѭ�2|4�xc�"�p�@8�:c�\5{�,Y�:�k+C��h�y�=��h�w�[2~�D�4���*�(��+mS�ϒ�ӧʷ��7[��o��Ez�kh�Y��K]U@�8Q&�S��Pg�SO(���*�����3f˴i���$�]�.-�a5�tie��/4�R�w��QP_2����S7�3ھ�-��M4�8}��A� _(Q({,-��M�dh�-��-N�i�&*hc	h��ߡ x[�P�>��q�>u��
h߬����ۮ�=����f���%*hci�����U6PT��%*h��+h�������Y]A#�i�
�=
�7��qP״��d���Sb[�{GG@{oQ������N�6�����%
��( �/�gζZ��3�G���8��#��K��A}�lMIl;�f�o��4�xc�Kh�A}ɀ�BR~,�5��/�A@B�#)�Ƒ���J��Y����CZZ@{wQ�e6��f@�8�h\��}��4
�����������:I ��SA���@]�qA�8�/о^a�n����qg��F@���_P ��P0�4vX�gq�4Ӿ�2��Y��
���^�:�w&������q�5�VAS[Ϊ���h��*-�1�%4��.g@S��Kh�ؚ8Z.xc�Kh�A]*�M��$��W@Sٝ9I G�� �HQ(u̘5�
h�>hZb�&�8��؏��PD"F8���f̮hJ"���14q���Q���0xc!`*��f̞-S����SO���Q%�!���B>C��_i���8mMQ�/-���8I`�Vf@�8Q��|a�.�8�B�8�G5qNu4eπf�+hf@�k�Ck{  ��|�����6q�X�^��}5�V�������Ў=����t  �08I@�s�>�3�ŷk"��v�y��  �� ��y���M��4��fۦ��v�ŗ��:  �:�����;nJhJ�-����K�̀v�y���:   �+�ssz@3���#�%~I��  �D@���K4  ���;��I��  <{@S��$�М�$@@  �3�)�/	8ڿ'	�   
�-�)��   j�V@{��24  �� �  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ��!�  �   dh   !C@    @��   B��  24  ���/�M2ڹ4  � ��v�����   ��W��_@�e��^  �z�����������:   �+Sg��/��5���  �^�9gv~m�𑵽   ��W]�_@6dxm�  @�2w�����ACk{   �k���_@�|���^  �z���/�]z�嵽   �ʍ7]��O=pYm�  @���;_X��u{�-7�WA��b~�	   ����u{�a=d՚r���<�颋��:  �y�[6�nW�^+��~K~�����   �+w�yk~���.��u   �S���w��������o�/��s�E���   u��}oݪ>gK��L{<��;�hg�C@  �C����_W�=�w~��̳.���  �W����g�W��   j���'���j=~��{d
  �pL�1[��׬��h}O?���   �����u�Ӣ�Y/x�^�2%��vZ_  @�Z�g@;���k{   ꕇ�/��v
   P���vl%��ߞ5   ���a�u�|��H�-��n���D~^   YTD#�z��ʍZ�=��/"{�<M�7���  �6�5����������ݍ����rE���  �7G%��[G��C��/>�o�Jd��sİ�r��}eQym/"  �o�
c�y�oʕW_#�|�~$Y2�����i3��O���)�Rۋ  P��f͎͢��Sd��	�t�V6Ki��i��F�"��C��ɧ���e  ��Z��\;o�T�r����L��^`  ��{0K�m׳b��U    IEND�B`�  �  p   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonBackstageView.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxRibbonBackstageView *dxRibbonBackstageView1;
	TdxRibbonBackstageViewTabSheet *dxRibbonBackstageViewTabSheet1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
	TdxRibbonBackstageViewGalleryControl *dxRibbonBackstageViewGalleryControl1;
	TcxLabel *cxLabel1;
	TdxRibbonBackstageViewGalleryGroup *dxRibbonBackstageViewGalleryControl1Group1;
	TdxSkinController *dxSkinController1;
      TdxRibbonBackstageViewGalleryItem *dxRibbonBackstageViewGalleryControl1Group1Item1;
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:	// User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif

:  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxRibbon"
#pragma link "dxRibbonForm"
#pragma link "dxRibbonBackstageView"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall T%FormIdent%::FormCreate(TObject *Sender)
{
     DisableAero = True;
}
//---------------------------------------------------------------------------

  �  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonBackstageView1: TdxRibbonBackstageView;
    dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl;
    cxLabel1: TcxLabel;
    dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup;
    dxSkinController1: TdxSkinController;
    dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

{ T%FormIdent% }

procedure T%FormIdent%.FormCreate(Sender: TObject);
begin
  DisableAero := True;
end;

end.
   �
  \   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxRibbonBackstageView1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    Style = rs2013
    CapitalizeTabCaptions = bDefault
    ColorSchemeName = 'White'
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
  end
  object dxRibbonBackstageView1: TdxRibbonBackstageView
    Left = 8
    Top = 166
    Width = 577
    Height = 266
    Ribbon = dxRibbon1
    object dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet
      Active = True
      Caption = 'Recent'
      object dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl
        Left = 12
        Top = 44
        Width = 300
        Height = 208
        Anchors = [akLeft, akTop, akBottom]
        AutoSizeMode = asNone
        BorderStyle = cxcbsNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.ColumnCount = 1
        OptionsView.ContentOffset.All = 0
        OptionsView.Item.Text.AlignHorz = taLeftJustify
        OptionsView.Item.Text.AlignVert = vaCenter
        OptionsView.Item.Text.Position = posRight
        OptionsView.Item.PinMode = bgipmTag
        Ribbon = dxRibbon1
        object dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup
          ShowCaption = False
          object dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem
            Caption = 'New Item'
            Description = 'New Item Description'
          end
        end
      end
      object cxLabel1: TcxLabel
        Left = 12
        Top = 12
        AutoSize = False
        Caption = 'Recent Documents'
        ParentFont = False
        Style.Font.Height = -16
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.LineOptions.Alignment = cxllaBottom
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 26
        Width = 300
      end
    end
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
  object dxSkinController1: TdxSkinController
    Left = 536
    Top = 8
    NativeStyle = False
    SkinName = %SkinName%
  end
end�  `   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 3 P R E V I E W       0          �PNG

   IHDR  h  p   ��u   gAMA  ���a   	pHYs  �  ��o�d  �IDATx^����u����f �:���0x����E��9b[��]�Cev3[)�5ʒ��.����i��ݶ6*���U�$���\ef�����fx�Ώ�������?�w�sޯ��M���+ �gr�5��+ ��v,���8	 �p@�p@�p@�p@�p@�p@�ÙN���Z[[[ZZ���� �/u������g��k�-O�߶'�g��6�ر����� �?�|s��]��8����˾[�����[�5=wҀw]�=zĈ�F����,XP�:�ŋ�NG����7���6��ˮ�ν{_ٱcW������8 �G۴�R��sv�%�Ǎ;}��a�Q�wV-����T��b�ҵ_|K�l��]�X1�'ߛ;>;w��Da~A��Ǡî�޺��[�ԓO��|�G�p��t���\�p:t��n���7��+�.vҼ��}pй��N�\QQQ�������%������g�l�����N8_U�L���Y�ùu붍_��k&Mx�y�C���74o�}��g6�|U��a�5o;���[w�j���'M_Sszaţ[�paq*I������8Y�֫kɄ���~��~�����_���۪���C]�9Y�m�F�Q{,��f/���}��m�;vz��A3��2�����T����G������C�>��3�~vM�]۷�\\��|��j�f�C?8o�Uł�뾍��$y�w��N�:�d����ő���
C��ܷ�0�a�#9�F.�g�\U\&�:�xa�m��-[�;�3;���N�N��}�;�s��]��^*��.m��կ���ww/�Fյ�^���8{°�����Oڹ+�@fӖ�{�ւ~i�]�r��}hf]7�k�,M[���dɭmy�:�j�;��{O�ڬ���X{��,�037�t��%�SxXq�Y�Lq#�'e�V8�ܶ륳�ϛzkrב7�	'��£�ُ��ta��C8��U����醆�g�6=�B&�nٴ9��ȴ��V�VTd+ޞ�.\�=R.��g>S���y��ȅ�<�]{ΛW����λ~͆�0������3WG;-yS~�-3�Oֿ���0���MIG�H�@8�m�o�9;3�8���9�d?�I�f���\6=ũ�N/�A�p6lЄ��\]2}�ns���~��F~�o\���?v�˪�ҩT��IÆU�zU��E*+�����©Z����{���K�v�3��.��Z��i�#��t���ɩ��g�t��^�R�9jԨ����%���y�������s�w�ߴ~��/����/v�so�礧_<x�����d۩��I��{�dl�5+�m|xŚ������'����n�o�ڗ�蓍����jv��M;;�U��Դj�##��o�|���0�I�S�︽�����K++�gn���pkk���-��&�'˗���->�_��`a�%kS�Lf���K7�aGy]GB9��9Q��c�='���j}�ew�u���P7_��vmݣ�>V�{��oݟji)���Vs���r�Yg^x��S��G���8JV6�gO�tՐ���/L�Mfe'\x���~��#N;Z5�:q�~j���>�o_}�����͹۸jNO̪���K�O�V\ ��nNնkll|��O?�f��M�SIrƙg��N����R\ ���� 褛k� �Q' ' ' ' ' ' ��,N��J�7}��G�S�6.���� m�_�P|u��N��^�n� �N N �pf�T�zR�9�8c����\����	ץ��$�� p��p�:#5}ѩW�]6�/�[^�ow��̤�)7V���ι��|hq9 8��A8V_�|����=��o�a�Mͷ.l��s?�w�n����2m﹟n�<��4 ��z��g��цM��~����a-�e�TYY�,����?n��ך�}�?�\6�� ��z�t&�w̻��i8���m؟�(O**JR����vf�qoSs垑צ3��$ի/@��xݎ�ݜ�я�<��&$I&��rh�+�U����C���(>���u[g�L.��f�׆dvW�;�/@X��-s6���Y�]5sbnꙏ/p�[�ϫʏo�亱�Y/�.<n���g�������zM�M���:����}�
���[X~ڲ�7\���YR���c�rk%��v�{W��&?ئd;��I�����C� �[�����g7����S_��%_uۧG����W�^0���ʆ�~ϟ�������g��M{R��J�ŵvξ;���j�e��_�;�뗎�}�3��ۗ�۶hF1Hmϝ����o��h��`Q����ZU׶��ƭ���^(��._�m��]w��sKF._��+�Ljn(��l\�.ګ��s�m[����@^�w�y� �R�¹�P��M��kLR����m��S����S/��9p�����>����x��/>�w���{�v�|%=����q�����@�m5W/�pi}��m��U�=;��qI]}�,�sNU׹�_x��e��D&'�oQ��k�wMq�M�<���-�:����'�<�d���=.q���	@O�*�M��dca:�Pߴn���O����Q���b���<�����I2��t&s��9]QX��s͸�e�G{c�͸h�Kf>�,;|V��3l��]S,_ٹ��u�M���7o�3�t�����v��)co��1h�[��L��`v���.>���/�*���:e��{eӍ���ʊ����cU�_W��OM�h�%��U�:mhey:����j���-I���	���[<r�-#���vv��ms�K.=|q�����]���rq*��eU+>��Dk�eÜ䣞�q�|��t�� �K�
����8�uԈ$ɜ��������o޳���+ϛZ6�������WF�������>v�YgV���Π�sq���Ԗ��$�j�����i�2a�ݎ�/"N^w�̶�u7��.����w����u+�\���i�ɇyb�EI�F�}{ ��^������tkr�u�,���]v�ƫ����Y���O{��ۛ���Lk��?~�����7$�~gY�eH�1���#����U�s��|��m���psm�v�P�1�f̪[w�S��S�� s�KO����7�v��ѭ\��}+.�Y�2��+�J�6�۷@_�U8�f����s&5�}v��!�И9ؔd2�2MM�%������/�����m����W��/+�X|{���S/<�`]���U���)�E�(w�(�Rs!�tY:8q�5�7����̺��� �]~��Gr_�5w�m���N������zβT2�y��7�Pwݵ�Nɔu�Z��bߌi믺j�֜������Cە���ŧ��Y�ض�g�̛2m���T�zʬ��Yܬ�M-^>����n�����������I�<IR*wh���c[V/�.��-�Xs�śW�|�o��ԫ/@(��0�+�vƦMC�����ҙtY�i�藯|��1c2M;�XU3�x��1;�/@�X��t��_�P0~���W�L�^|v�Еo��_o~�w.�����\y��NX���������A�3k̩o���%?�~��|Sz��e/��<�Ɓ+f�]=bPKq9 8��M8�*�2�6�|��M���7����-o>k�YC���uM xM�Y8�?N 胻j�h6LX\��s��k��G-NPbҋr�,}� 8��y ��� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��?Z�`Aq*H8�w
�<�v
' �Ki/����	@?�^�ŋ&��N ��N�<�v
' �E�^fuyU���sŨ9�_ G�cٕ�8 @8 @8 @8 @8 @8 @8  ��	�?�ߚ��_�  =�  F8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8  ��w�(N ��' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' �X��?�_�XP�    IEND�B`�[  p   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxBarEditItem.hpp"
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonBackstageView.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxRibbonBackstageView *dxRibbonBackstageView1;
	TdxRibbonBackstageViewTabSheet *dxRibbonBackstageViewTabSheet1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
	TdxRibbonBackstageViewGalleryControl *dxRibbonBackstageViewGalleryControl1;
	TcxLabel *cxLabel1;
	TdxRibbonBackstageViewGalleryGroup *dxRibbonBackstageViewGalleryControl1Group1;
	TdxSkinController *dxSkinController1;
      TdxRibbonBackstageViewGalleryItem *dxRibbonBackstageViewGalleryControl1Group1Item1;
      TdxBar *dxBarManager1Bar2;
      TcxBarEditItem *cxBarEditItem1;
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:	// User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif

 X  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxBarEditItem"
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxRibbon"
#pragma link "dxRibbonForm"
#pragma link "dxRibbonBackstageView"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall T%FormIdent%::FormCreate(TObject *Sender)
{
     DisableAero = True;
}
//---------------------------------------------------------------------------

E  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView, cxBarEditItem;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonBackstageView1: TdxRibbonBackstageView;
    dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl;
    cxLabel1: TcxLabel;
    dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup;
    dxSkinController1: TdxSkinController;
    dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem;
    dxBarManager1Bar2: TdxBar;
    cxBarEditItem1: TcxBarEditItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

{ T%FormIdent% }

procedure T%FormIdent%.FormCreate(Sender: TObject);
begin
  DisableAero := True;
end;

end.
     \   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  PixelsPerInch = 96
  TextHeight = 13
  OnCreate = FormCreate
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxRibbonBackstageView1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    TabAreaToolbar.Toolbar = dxBarManager1Bar2
    Style = rs2016
    CapitalizeTabCaptions = bDefault
    ColorSchemeName = 'Colorful'
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Tab Area Toolbar'
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxBarEditItem1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'Text Edit Item'
      Category = 0
      Visible = ivAlways
      PropertiesClassName = 'TcxTextEditProperties'
    end
  end
  object dxRibbonBackstageView1: TdxRibbonBackstageView
    Left = 8
    Top = 166
    Width = 577
    Height = 266
    Ribbon = dxRibbon1
    object dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet
      Active = True
      Caption = 'Recent'
      object dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl
        Left = 12
        Top = 44
        Width = 300
        Height = 208
        Anchors = [akLeft, akTop, akBottom]
        AutoSizeMode = asNone
        BorderStyle = cxcbsNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.ColumnCount = 1
        OptionsView.ContentOffset.All = 0
        OptionsView.Item.Text.AlignHorz = taLeftJustify
        OptionsView.Item.Text.AlignVert = vaCenter
        OptionsView.Item.Text.Position = posRight
        OptionsView.Item.PinMode = bgipmTag
        Ribbon = dxRibbon1
        object dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup
          ShowCaption = False
          object dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem
            Caption = 'New Item'
            Description = 'New Item Description'
          end
        end
      end
      object cxLabel1: TcxLabel
        Left = 12
        Top = 12
        AutoSize = False
        Caption = 'Recent Documents'
        ParentFont = False
        Style.Font.Height = -16
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.LineOptions.Alignment = cxllaBottom
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 26
        Width = 300
      end
    end
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
  object dxSkinController1: TdxSkinController
    Left = 536
    Top = 8
    NativeStyle = False
    SkinName = %SkinName%
  end
end   `   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 P R E V I E W       0          �PNG

   IHDR  h  p   ��u   gAMA  ���a   	pHYs  �  ��o�d  �IDATx^����u}��}�ۻK�.!/�pA	D�8�R	��Pk�`4JU��Xeƶ��vpj�vt*:m�a���X��Zъ
i-�("��]L����[n�e��{�w���_���|f'y��>�<{��}����%ݱ�5 �L�; p� � � � � � � ���T6{��Ԝ���qI�T��ٿ�Kdҥ� �}&��I��/{o~^��={v�L��5K��ϛ߳w{�7�v=� ��$��;����Яw��z{��_�TS��g�nX_Z�8��Ks��[`�-�|K�uD{n]�l�8�����WT����t��M硦W����{�m���MM\�H������s�lC߶df��7l���)��^�۞J5]�x��w�Q_g��ˋ��䀪I���Ky_�Ï';<��w�i~���p�^k�i'�b*�Ċ����k����9��x��=O^���SO���\���Nc*�rm�y��;>:��U�L�sF��sڑ�2J8�քLN��e��U{�ne�`>��U�lް�i��u/]��;��-��楳��?xC�^������9k�L�tj��ͱ�d���H�d��=�)��죷'����H�ױ�Ç���~co��3j���d�H5�ƅ��TKϞ=�=\�zU�����']���߿8�x�����������~��9?ҳw�����=��o_:�����CKkM�}��_y.�źт6]ո�{��׸r�?1)�Z����Yy��งOe��4��b�kk�OؒS> ��<~�'�ٖ�_��Mw�7��Zy{x��7!��/��g�v��7�Re����|��}����uo<x����O����w�ه��>�-�J���l~�J��W[���߽y(�,�2�{�E��j��kFjz���.�lh�E����F��,�twep�����5��我K'���$���&k�#��z�y�kH�ǧ:9�9�^���߫ӕm�m��Yf6��.vw~���c�*��;S�\i` ]��7�+6�G0v��|KF���V���⩭����p���7��\�IJv�`����ګwN8���W~�|�z�r��~SҔ'h}��ȥ+'��|�HO������8z^U��{�ů��P���L�/���U��}��s�[�������w>��:���g���t�W4��?�i�]��T��J�ͽ���i�����4� Ln������2�ष����/�э��M���b[zΜԹ����]��+�/�\�7�����񽟺��?�w�M��(�zŜ���mOv�{��<�=|��S�����,�ִ�Ƒ��ო;�Rkj�_�l�����##f�$�|4��6���qG�/�jzߢB�鯯K&��jj�>��Ά̋�|�6��(�N�>�]�Ź-�uwG>�ܛڙ�9uY���S�Շ6XI]�ŗU��VHN8���.Tu�H�$G>9�G�m����>s�����WT����t��M�����x����/��/��|2��\��W\���N����Y�����[�}�d~�@gw����^�X(�;���o�-f2}/{��ַ55/��M;���Ye��U[�ˮ���t��҇�vs�b]]m����V�"9 f���Y�;��v`�O6��WH�RK�Ϝ�}Vsǜ�7C0{MN �pG�C �2�� �� �� �� �� ����s�/�1�b���d��s�sٲ��2�1kkkN�(K�  �  � 0c�,�ҥ�3�+.�[���_�_����뗤R�7 �?f&���-�UoX{C挷w��s_co��싯̽��+�3�mN��������eųߟ)f�n�Vv˽M���g*��S�~������=ٸ���B[��]���]� �`�3���e��x_w�>v�I��2o`0�Ng2�L:������M��~��'���?���K '�i��XJ8������>�����t.�������l�/�T���_��X����lZ��9�;����o5մ�Դ��[�8]��-8)�hQ:���7�,]�Զ���֞՛Y�<�ٱup�v%;c��/)��wUǺ��O��QS�*b���7U7�|�	��k��3���s6 �9�
���κ;��p��S>��E����>:��w�_����<3��鲷��U�����~����?��}Uryv����M�U�z������>�k�wƵn���+�MvS�s�W_����3�]ђ���&��gδ¹���}g]gO*����#�?�'��s�Z]:t���m�>�sZ_�线:p�n�����G>g-Y�M�(Ms*��Zr�:��&ٛ��= G2�pөޞ��bwW���~���oڲ�um�v��<�����Y�T�K��B17|�qUYt��Y��%ۻn(l�c����j|M�2��(�=�$U��\�|K�|����ÃS,�N�%��&Ce�> ��i��&3T3���{z��|n�C[��q��]��S�+��}e�\����|�X=�x�:��̪��gM��K����G2���P��R���?�a�Жj�v��'#cmږ�Y�)���ԣ����O]�<X|`��ۇ����*�xj	���M}] ��i�s~�@}K���T��5��k��7v~���/��mx�����g�c�'.9���eM��#����b��%��􊷏�
x^nUjp�'S�>02R}eq����?YؖgϩִqCv��T���k�^��^k�+Ϋ�~���������1�j�'�q2�p6<6XL����_����;.^���o|��p��ni�����olj[������[ߜ)���U����5g�:��g�dٛtp&t��_�Wf����O��]��M+�ͥ�}�h_qf������bwO���*����
���b�����Wt,]��������;�[2]�U_n,=v�ȼ��H��#��7ЎQ��f&Y��^�]�i��b�Ȝ����R?(�|�e跣G��R���P��Ce�> ��i�3�N��ׯ��ȥ��^��Rf��J�\��s���u���i���?���U>aRy�r ����l���O�zk6u^����TL=8apy��ӕ%��K�O��6x^���f���-�d֎y�����-��=ؖyj�9��8���U��{�Z���kioo��=������b&]X��c��N>�T�{N�]K�$￝~V���Y� �`�Y�D�܇V\��[8�k�@wOMSc~�|͂���;���ɡ3D8�O8����jG���������Ω�����=�����������& <[ff�y��qN�'�1��' ��	 ��ڎ�ߘ�P,�NS[[[���Y�ӫ+�̯۔  S+l��R- ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ����_�l	' ��p5����	��2����N�`-�5�\3�m�p0[L�汵S8�-&���𑧕��ؚ_�)� �V�|�' ' ' ' ' ' ' T>�����= `j�zu%�=�ߒ  S�s��j @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8  ݱ����I� ��5�׻�8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8  ݱ��Ы��� S����f�  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  � �������/'{ ����y�' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' �;6�Z7&{ ���w��' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' �;6����5� �V��r3N N N N N N N N N N N N N N N N N N N N N N N Hwll��d �Z��n�	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 �	 鎍����J� L-w���8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8 @8  ݱ�5�nS� L���3N N N N N N N N N N N N N N N N N N N N N N HwllM6�#K��`�h�V�O    IEND�B`�a  |   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 T A B L E T C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxBarEditItem.hpp"
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonBackstageView.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxRibbonBackstageView *dxRibbonBackstageView1;
	TdxRibbonBackstageViewTabSheet *dxRibbonBackstageViewTabSheet1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
	TdxRibbonBackstageViewGalleryControl *dxRibbonBackstageViewGalleryControl1;
	TcxLabel *cxLabel1;
	TdxRibbonBackstageViewGalleryGroup *dxRibbonBackstageViewGalleryControl1Group1;
	TdxSkinController *dxSkinController1;
        TdxRibbonBackstageViewGalleryItem *dxRibbonBackstageViewGalleryControl1Group1Item1;
        TdxBar *dxBarManager1Bar2;
        TcxBarEditItem *cxBarEditItem1;
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:	// User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif

   X  x   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 T A B L E T C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxBarEditItem"
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxRibbon"
#pragma link "dxRibbonForm"
#pragma link "dxRibbonBackstageView"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall T%FormIdent%::FormCreate(TObject *Sender)
{
     DisableAero = True;
}
//---------------------------------------------------------------------------

E  t   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 T A B L E T D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView, cxBarEditItem;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonBackstageView1: TdxRibbonBackstageView;
    dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl;
    cxLabel1: TcxLabel;
    dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup;
    dxSkinController1: TdxSkinController;
    dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem;
    dxBarManager1Bar2: TdxBar;
    cxBarEditItem1: TcxBarEditItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

{ T%FormIdent% }

procedure T%FormIdent%.FormCreate(Sender: TObject);
begin
  DisableAero := True;
end;

end.
   !  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 T A B L E T F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxRibbonBackstageView1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    TabAreaToolbar.Toolbar = dxBarManager1Bar2
    Style = rs2016Tablet
    CapitalizeTabCaptions = bDefault
    ColorSchemeName = 'Colorful'
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Tab Area Toolbar'
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxBarEditItem1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'Text Edit Item'
      Category = 0
      Visible = ivAlways
      PropertiesClassName = 'TcxTextEditProperties'
    end
  end
  object dxRibbonBackstageView1: TdxRibbonBackstageView
    Left = 8
    Top = 166
    Width = 577
    Height = 266
    Ribbon = dxRibbon1
    object dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet
      Active = True
      Caption = 'Recent'
      object dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl
        Left = 12
        Top = 44
        Width = 300
        Height = 208
        Anchors = [akLeft, akTop, akBottom]
        AutoSizeMode = asNone
        BorderStyle = cxcbsNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.ColumnCount = 1
        OptionsView.ContentOffset.All = 0
        OptionsView.Item.Text.AlignHorz = taLeftJustify
        OptionsView.Item.Text.AlignVert = vaCenter
        OptionsView.Item.Text.Position = posRight
        OptionsView.Item.PinMode = bgipmTag
        Ribbon = dxRibbon1
        object dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup
          ShowCaption = False
          object dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem
            Caption = 'New Item'
            Description = 'New Item Description'
          end
        end
      end
      object cxLabel1: TcxLabel
        Left = 12
        Top = 12
        AutoSize = False
        Caption = 'Recent Documents'
        ParentFont = False
        Style.Font.Height = -16
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.LineOptions.Alignment = cxllaBottom
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 26
        Width = 300
      end
    end
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
  object dxSkinController1: TdxSkinController
    Left = 536
    Top = 8
    NativeStyle = False
    SkinName = %SkinName%
  end
end   �  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 6 T A B L E T P R E V I E W       0          �PNG

   IHDR  h  p   ��"   sRGB ���   gAMA  ���a   	pHYs  �  �(J�  BIDATx^����w}����ދ�;ɖ%[��`ca@-/���K�.�b'fn��Ɠf�6�:fJ�'��L�aH:.�(4ImH1��vKM��q�A�dI�^�E���ݽG�I�bY�����|fv����7�4�����{�=[7� �4�ů  $!�  �h  �4 �d @2  � ��@ H�E?�����������ڵ&j�j��#��o��<�Ϲ �K���������+z��޽1�sg�J�h]�6:V���E�o?m}O[  p�f��s���_��?�w~9���$Z�������WE��Gm��h���X���b �ɪ�(����wn.�-'�5:�_��9�t���Nִ�v��M1|ɿ�������ߣ�d�-E��wF��ǲg>�CO#����yÇ��'�a����`o�I�-�u�U1z�?��C��n�j���z/�ml.L=��S'T,���R����7�����9������)�V��xv�Gc���X���G������F�[~-����}<Z�3Θ/[��U�m������|$F'V(,t�����Ĝh|L&Цw:�.Ӆ�|�YÔwq\�!�ڣ�������X~���}�u���m��e�����ʊQ��D�?y{t���r�]�7�4�^\�X�z��YOT��e��o����/5_o�z��bu������6���0��8k�h���Qػ7:�x2:.�m��$���q�~=���QY�*κ�}���5�������K�|*����W{��M���H�6�T5�\�I,�k�i��Y��7�k�q���il��GgO����o���ؔ}���w�R��h=r���o�[��?�c��;V��_�J�����\&��Bl�bq�����iTjS��?������QtmyG����vх��7������\}݈Z����Xgs`1Z������8��/�x1r��zӟo���~)⵷N�����at�1�X��b�r���o�]?fc�G����s��&�cW'��ʡ��cG�k'�c�X�W����;6L�eQ:���4�̢7%�YV)W&���1�����g~�j5F{wF��Dmt4JKڋ�/5���;`����NN��M�DJ}�G�x;�ڹ.�Gch���WF%������n�'�5�t����1UL�����=�c�	&�c�X��M�rRJG��L�Zj>'��0���Z�����Z���q��8������mq��?�s��oF���7��п��>y{�����J������6��X��3�TO,9����g��������)���2{1G���M��7��&�9���fJ�-���ҥ�]��y��敲���n��Wc��ž��t|��x��.�W����7��sΉeCۊ� ����w��1S�����uE�u�5Z�&]��i����+��ȽaݷĒ�'ow
�s�����qv�|Fڔ�������U��������X12�Zkk�}�#q������hkܐ,2�����ƍ��z��ol���c��Έ���5�;�yi�>��k�����*S�G�u����˄�^�;�}���'�|���-���ίK�f:�lc'k���6|a����x�������z��IFG4�l��7��.��2^�鿜  �j��������V.���x��E������j��Cl�|u���5C��g?� ���h��?*�9���+>��;���k�Duɒh+ǆ���zvb  N٬��08Z����>���n��w��������d��X����  s�E ���'� $#�  �h  �4 �d @2  � ���A;E{���٭���g ��@;�8[�n]�Dv;v�i �Lq $#�  �h  ��{�բ����Xr���Ϋn�������jǚ��� h��@���ƏF��OG�U�Wġ�b�V�׼/Z���1���c���� �y{�P����ߌr����ZTx8�GF���G-E��%Qz���~Օ16�\tm��h�1��»8�,��	��b^���,Y�_����}6�����o=+FǢ\�r��(E,��?�;�?���8��#��  �9�j��}W���O}&��F����2�Q�T�{������cx�=�����}��Ө�9� �P�<�Z/�������b��x�����G���Qjk���gG˪U�8k�rGg��]�;v������Kb�|N���g���My�>���=�2����)���I��]�P�Wb�足��Ŏq
v}�~N���bq��Ǟ���3���9��;�8 �r6�v�rQ��%�~3:��2���'bՇ?�?��X�_��7�>V���(��<�o��8�7n���o|+�c�=]S]��wG���c�51�x*]7Dۖ�FKWs�Ӭ7���W=+�+�K�������/�w���b��j�� ��ٜ������K4�0�b�o}0����Ο�<j�����U�7�t�[b��~/��%�����`ue���猚�\se=T�Gm>���$=�҈�K�,����: �1�6<V���Y�����t��1��QY�*���z����8��_��ߏ�բ\�Emh8F�-Ŗ���S��>�ٜ�<~�o�J���Ɣ�_i�����񮫣Ҽj6��`�t�.�46�|��S�G��Lczq�}�D�L�~�����l� �ȜZky<ZW�n���@��ۣe�8�����믋�{�*:.}ct\����Z*�q��h�T'�O�#Q6���գ�;��qb�5*�j\)�p��_���u�I6�P|��oL�5�eו�~�����{��gИb�|s�?9)�f;�|c��'G_}���1c��Z��N�1S�?��� �9��*���'�V5�*k���+�G_�\��_D���EyYg<�۷ƾ��T����De��1��X~���.���8-o��j��Qi������L���h�1v�'"6�֤׋{���R�٣�R}�K�x�!*k�E�7�fk�O\��|��n�O�bz�y�#6?q��c�s��e��{����E\]��K���6��k���_xG<�������}��Q�Cqw���1�W�N��_�rm4�����S�å���1~B�����lc�1�ڸ2ؼ����4�t��  �9���1����]q�\tQT��돁��e�{ͪ�Gm����Z���`^��سvM�ѷby�����UWO�����>��3wM��TLmn�pđwj�qŭ<��߶��.�ﱨ�M�26�X�|��Q����?�������u���|�0۹��2���)��?��q<uݖz�k�V��0���8t����5���>�>����1������{�F��b*��&�OD��w՗���%���ӼI�9ָ�~������ɉ)��}e�N�N?V?��}g�3�@��`����К��펉7|wG����6۹��2o?�s{�9�ף�bYǊ�����?m��R��z��^{6�9v�{nԆ�ťm��ڥ/���L�gq�Y�,N ��h�.�'F/�c����p޵+F����+�W��%�������O�ʎ�b�3�@;�4 �s>�9ٹ����]��e-�W�-�ި�퍶�(�oY��x�ysF� �|��+h/w���Y\A�L1�W�  x� @2�)��T'�癣1�	 �5n�iZ�g# ���	j�  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ ���~{���	4 �St$��*� �)8>��"� �I�c��zk���#M� ����l�"M� ��颬a��_�Ҟ��j�[�. XH����4 �l @2  � ��@ HF� $#�  �i~ڞ7|�X `!���&m�;��  XHK��' @6  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  ɔ�l�T|�) XH��뽮� d#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  �Ҟ��j����b ����𯺂 ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2�=[7Ն���b ����_q  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  ɔ�l�T޴�X `!�?�O]A �F� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  �Ҟ��j#��, XHm��
 @6  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �)�ٺ�6�ֻ�E  R���q  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  ɔ�l�T��?+ XH-���4 �l @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $SڳuSm��/�  ,�ʷot  � ��@ HF� $#�  �h  �4 �d���־��b ��4|�;]A �F� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2  � ��@ HF� $#�  �h  �4 �d @2�=[7Պ�  ,����;��>�}�    IEND�B`�   [  p   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 9 C B U I L D E R H E A D E R         0          //---------------------------------------------------------------------------

#ifndef %ModuleIdent%H
#define %ModuleIdent%H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxBarEditItem.hpp"
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxGraphics.hpp"
#include "cxLookAndFeelPainters.hpp"
#include "cxLookAndFeels.hpp"
#include "dxBar.hpp"
#include "dxRibbon.hpp"
#include "dxRibbonForm.hpp"
#include "dxRibbonBackstageView.hpp"
#include "dxRibbonSkins.hpp"
#include "dxRibbonStatusBar.hpp"
#include "dxStatusBar.hpp"
//---------------------------------------------------------------------------
class T%FormIdent% : public TdxRibbonForm
{
__published:	// IDE-managed Components
	TdxRibbon *dxRibbon1;
	TdxRibbonTab *dxRibbon1Tab1;
	TdxBarManager *dxBarManager1;
	TdxBar *dxBarManager1Bar1;
	TdxRibbonBackstageView *dxRibbonBackstageView1;
	TdxRibbonBackstageViewTabSheet *dxRibbonBackstageViewTabSheet1;
	TdxRibbonStatusBar *dxRibbonStatusBar1;
	TdxRibbonBackstageViewGalleryControl *dxRibbonBackstageViewGalleryControl1;
	TcxLabel *cxLabel1;
	TdxRibbonBackstageViewGalleryGroup *dxRibbonBackstageViewGalleryControl1Group1;
	TdxSkinController *dxSkinController1;
      TdxRibbonBackstageViewGalleryItem *dxRibbonBackstageViewGalleryControl1Group1Item1;
      TdxBar *dxBarManager1Bar2;
      TcxBarEditItem *cxBarEditItem1;
	void __fastcall FormCreate(TObject *Sender);
private:	// User declarations
public:	// User declarations
	__fastcall T%FormIdent%(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
#endif

 X  l   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 9 C B U I L D E R U N I T         0          //---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "%ModuleIdent%.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxBarEditItem"
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxGraphics"
#pragma link "cxLookAndFeelPainters"
#pragma link "cxLookAndFeels"
#pragma link "dxBar"
#pragma link "dxRibbon"
#pragma link "dxRibbonForm"
#pragma link "dxRibbonBackstageView"
#pragma link "dxRibbonSkins"
#pragma link "dxRibbonStatusBar"
#pragma link "dxStatusBar"
#pragma resource "*.dfm"
T%FormIdent% *%FormIdent%;
//---------------------------------------------------------------------------
__fastcall T%FormIdent%::T%FormIdent%(TComponent* Owner)
	: TdxRibbonForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall T%FormIdent%::FormCreate(TObject *Sender)
{
     DisableAero = True;
}
//---------------------------------------------------------------------------

E  h   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 9 D E L P H I U N I T         0          unit %ModuleIdent%;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, 
  dxBar, dxRibbon, dxRibbonForm, dxRibbonSkins, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxClasses, dxRibbonBackstageView, cxBarEditItem;

type
  T%FormIdent% = class(TdxRibbonForm)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxRibbon1: TdxRibbon;
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbonBackstageView1: TdxRibbonBackstageView;
    dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl;
    cxLabel1: TcxLabel;
    dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup;
    dxSkinController1: TdxSkinController;
    dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem;
    dxBarManager1Bar2: TdxBar;
    cxBarEditItem1: TcxBarEditItem;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  %FormIdent%: T%FormIdent%;

implementation

{$R *.dfm}

{ T%FormIdent% }

procedure T%FormIdent%.FormCreate(Sender: TObject);
begin
  DisableAero := True;
end;

end.
     \   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 9 F O R M         0          object %FormIdent%: T%FormIdent%
  Caption = '%FormIdent%'
  ClientHeight = 480
  ClientWidth = 640
  PixelsPerInch = 96
  TextHeight = 13
  OnCreate = FormCreate
  object dxRibbon1: TdxRibbon
    ApplicationButton.Menu = dxRibbonBackstageView1
    BarManager = dxBarManager1
    SupportNonClientDrawing = True
    QuickAccessToolbar.Toolbar = dxBarManager1Bar1
    TabAreaToolbar.Toolbar = dxBarManager1Bar2
    Style = rs2019
    CapitalizeTabCaptions = bDefault
    ColorSchemeName = 'Colorful'
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'dxRibbon1Tab1'
    end
  end
  object dxBarManager1: TdxBarManager
    Left = 568
    Top = 8
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Quick Access Toolbar'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Tab Area Toolbar'
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cxBarEditItem1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'Text Edit Item'
      Category = 0
      Visible = ivAlways
      PropertiesClassName = 'TcxTextEditProperties'
    end
  end
  object dxRibbonBackstageView1: TdxRibbonBackstageView
    Left = 8
    Top = 166
    Width = 577
    Height = 266
    Ribbon = dxRibbon1
    object dxRibbonBackstageViewTabSheet1: TdxRibbonBackstageViewTabSheet
      Active = True
      Caption = 'Recent'
      object dxRibbonBackstageViewGalleryControl1: TdxRibbonBackstageViewGalleryControl
        Left = 12
        Top = 44
        Width = 300
        Height = 208
        Anchors = [akLeft, akTop, akBottom]
        AutoSizeMode = asNone
        BorderStyle = cxcbsNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.ColumnCount = 1
        OptionsView.ContentOffset.All = 0
        OptionsView.Item.Text.AlignHorz = taLeftJustify
        OptionsView.Item.Text.AlignVert = vaCenter
        OptionsView.Item.Text.Position = posRight
        OptionsView.Item.PinMode = bgipmTag
        Ribbon = dxRibbon1
        object dxRibbonBackstageViewGalleryControl1Group1: TdxRibbonBackstageViewGalleryGroup
          ShowCaption = False
          object dxRibbonBackstageViewGalleryControl1Group1Item1: TdxRibbonBackstageViewGalleryItem
            Caption = 'New Item'
            Description = 'New Item Description'
          end
        end
      end
      object cxLabel1: TcxLabel
        Left = 12
        Top = 12
        AutoSize = False
        Caption = 'Recent Documents'
        ParentFont = False
        Style.Font.Height = -16
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        Properties.LineOptions.Alignment = cxllaBottom
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 26
        Width = 300
      end
    end
  end
  object dxRibbonStatusBar1: TdxRibbonStatusBar
    Ribbon = dxRibbon1
  end
  object dxSkinController1: TdxSkinController
    Left = 536
    Top = 8
    NativeStyle = False
    SkinName = %SkinName%
  end
end �  `   D X W I Z A R D T E M P L A T E S   R I B B O N 2 0 1 9 P R E V I E W       0          �PNG

   IHDR  h  p   ��u   sRGB ���   gAMA  ���a   	pHYs  �  ��o�d  IDATx^���o]wa���/t��T}�xR�G�HU�hC0"���HU��U�� m�V6Q# �BX���P�+V�*eu���$u�y���NZ�Em�����s����Ǿם��[/E�����n�G����~�& `L� � � � � � � � � � � �6ᾷ����L����^]x�p���i��Mx�wf�������r���]���֩u��}�M?��Mh���̻WgV�{�'7aR���c���0$ۯ|Q#j]<Y�s>K}jSO�ùt�bS뽰5�k�N�U��ި�G���N��'�~���ol�y�q�&4�kf��ʁ7Nvf���Of��ԡ';/�VgJ�K�Օ�3��5/�6��o�y{a��/>u���م�Wz����|��?��r���<ٺfw�Em��[��U��N؄2E��k����zM��s��aE�{������u��ٽ�.3�??�������wW��?ȫ�5��yͮ1�ڶ�����zW�K��	e��������N�t�,��m�Ɂz��G?�=��g�?�{�Y�^�ᜊη�W�]�m�㴚�.�����B�Ʈ:���o��]��I�y�i�Ȯ��6��2#����z˳�j]0��{��j�����A����U[�dw�Z'Gl��3�?�z�l��?��93A��X�֕�5����E���4�͔��M����ڬ��s�s��B�8��?ٙ��wvz7Y_����==��g��?�M���ο(�Ժr�F<�6<uՆ'�d8�O��z�Z��_�:�.���O���5� 0� 0� 0� 0� 0� 0� 0� 0� 0� 0� ���K+ ��' ' ' ' &9���K�r����*�'�� ��6��\�x��t��o�Y޼��\��r����o���ٿ v��g����L���'��'o�w�s3��/���S�������W~��_k}  �,����2�����d���[^�X�˟������\Q&��� ��lu8�M���LY�r����O�����ǯN�>}�k� �\[�K+�e2�>������-��PnF�=��rqZ�.����\\\��f{�������_�r�§>STe2��rp�C7���;���9���?��wj��9t�uו��+�^�o~�Ճ�G=�{���Է?�9~��=�FǞ�s��w�|��0a[�ӧO?u�����]���̿w�ʻ�/_YZ~��3�{[9S�j^��w��r���7<��o<��/Ξ=�z�io8��iO}8�K9�s�g;��}����li8˽��G�p맫�|��r���=_��Q?����c������Y�s��7��������~~�ܧ�jڒ����<8۸`:��y�;�w�n2ù�0)[�r���~���o���l乏|��b���`�2�e>�m���(��,�ʖ�=��s����j���p�g�8����qc8g��\����Sup��w��^>z�w�Ro[ufϞ���=���>��1G?uǐ`R&9�嶲����P�y�weD�d�-�:�ᏼ�Y�Uw�7��g�+冲;���Tù���G�gu�ꪍ8��Σ���q�;�p���|��'�mi8�;������g�w�e ���+K˿��^��ke>�}gyW�-�Z���m��:����T����Z���ۿ���j���P��Կ%v����+�k:z�g�s�ϧ��pLі����ｿ�ꗃ�X�;���L9(�YƲlg9�9����~���W~�z�i��p����Сvr�Y=���1��?�pLі����<�L���X��,˟�oU����s�O�������CMCc~�-���:�����T9��A�����Z��'�Ik_����}³��C����!��li8����|�ũ��{9B�v�����?�Pݫ��uY�{�MNwϚ��۹�f�3=���Г�����lr8W��=������	0E[�b��s��޿=���mߨ���������O-��v �a��Y���=�������|��>tS{>��Жw�}-�f�Z ;�����r��2�e��y��{�����~�(��տ+'�{�	�N7��,�v.�z��˭�}����_��?��(��r�<z����G��3��,]�xn~��#OW�Y��̣�>W6��
 ��$� v��<����=`�ʏVù���' lQ��j8w����-*?Z�' ��p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�pp��뮻Zg�a8��լj�ߐ���Sof��{G3� \[���e}�l���R�dc)���N�	��e�F������������������������������@=�/��$ ��z8OK��1���$I�z8�J��1���$I�z8%I�NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�S�� �)IR��$)�pJ�d8%I
2��$NI���$IA�p^�� l�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�p@�N `,n�?�<��    IEND�B`�  �      �� ��     0          (       @         �                     	

!! ##"   	
	 ! ##"%%$(('	
	  ""!%%$''&**)	

""!$$#''&))(,,+TUT	

!! $$#&&%))(++*..-���565	
	!! ##"&&%(('++*--,00/������	
	  "#"%%$''&**)--,//.221���������	

  ""!$%$''&**),,+/.-110443������������	

!"!$$#&&%))(,,+..-10/332665���������������	

!! ##"&&%(('++*.-,00/321554887������������������	
	 ! ##"%%$(('**)--,0/.221554776::9���������������������	
	  ""!%%$''&**),,+//.210443765998<<;������������������������%&%	

""!$$#''&))(,,+..-110432665987;;:>>=���������������������������WXW!! $$#&&%))(++*..-00/332654887;:9>=<@@?/Nɱ�����������������������������!! ##"&&%(('++*--,00/221554876::9=<;@?>BBA/O�/Pˊ�����������������������������@@?  "#"%%$''&**)--,//.221543776:98<<;??>BA@EDC/O�/Q�.R�p��������������������������������))( ""!$%$''&**),,+/.-110443765998<;:?>=AA@DCBGFE/P�.Q�.S�-U�Gk�������������������������������sss!"!$$#&&%))(,,+..-10/332665987;;:>=<A@?CCBFEDIHG/P�.R�.S�-U�-W�,X҉��������������������������������\\\(('++*.-,00/321554887;:9==<@?>CBAEEDHGFKJI/Q�.R�.T�-V�-W�,Y�,Z�Fpڼ��������������������������������||{0/.221554776::9=<;??>BA@EDCGGFJIHMLK.Q�.S�-U�-V�,X�,Y�+[�+]�*^�_����������������������������������噙�PON998<<;?>=BA@DCBGFEJIHLKJONM.R�.S�-U�-W�,X�,Z�+[�+]�*_�*`�)b�z�������������������������������������ړ��YXWDCBFEDIHGLKJNMLQPO.R�.T�-V�-W�,Y�,Z�+\�+^�*_�*a�)b�)d�(f�^���������������������������������������ܣ��xwwNMLQPOSRQ.S�-T�-V�,X�,Y�+[�+]�*^�*`�)a�)c�(e�(f�(h�'i�B~撵������������������������������������������޽��.S�-U�-W�,X�,Z�+[�+]�*_�*`�)b�)c�(e�(g�'h�'j�&k�&m�%o�N����������������������������������������.T�-V�-W�,Y�,Z�+\�+^�*_�*a�)b�)d�(f�(g�'i�'j�&l�&n�%o�%q�$r�$t�?��v����������������������������-T�-V�,X�,Y�+[�+]�*^�*`�)a�)c�(e�(f�(h�'i�'k�&l�&n�%p�%q�$s�$t�#v�#w�"y�"z�/��Y�����������������-U�-W�,X�,Z�+[�+]�*_�*`�)b�)c�(e�(g�'h�'j�&k�&m�%o�%p�$r�$s�#u�#v�#x�"y�"{�!|�!~� � �� �� �� ��-V�-W�,Y�,Z�+\�+^�*_�*a�)b�)d�(f�(g�'i�'j�&l�&n�%o�%q�$r�$t�#u�#w�"x�"z�!{�!}� ~� �� �� �� �� ��-V�,X�,Y�+[�+]�*^�*`�)a�)c�)e�(f�(h�'i�'k�&l�&n�%p�%q�$s�$t�#v�#w�"y�"z�!|�!}� � �� �� �� �� ��-W�,X�,Z�+[�+]�*_�*`�)b�)c�(e�(g�'h�'j�&k�&m�%o�%p�$r�$s�#u�#v�#x�"y�"{�!|�!~� � �� �� �� �� ��   ,Y�,Z�+\�+^�*_�*a�)b�)d�(f�(g�'i�'j�&l�&m�%o�%q�$r�$t�#u�#w�"x�"z�!{�!}� ~� �� �� �� �� ��   �                                                                                                                          �  h      �� ��     0          (                @                  	
	!! %&%	 $$#))(CCC	##"(('--,���565""!''&,,+110������

!! &&%++*00/654���������565	
	  %%$**)//.443:98������������FGF$$#))(..-332887>=<;Y����������������##"(('--,221776=<;BA@/P�;^ѣ��������������VVU""!''&,,+110665;;:A@?FED.Q�-T�,X�a�����������������RRQ0/.554::9@?>EDCJJI.R�-U�,Y�+\�*_؇����������������̄��JJIDCBIHGONM.S�-W�,Z�+]�*`�)c�(g�x�������������������Ц��{zy-T�,X�,[�+^�*a�)d�(h�'k�&n�@�ꄱ���������������-U�,Y�+\�*_�)b�(e�'i�&l�%o�$r�#u�"x�!{�:��T��y��-V�,Z�+]�*`�)c�(f�'j�&m�%p�$s�#v�"y�!|� � �� ��-X�,[�+^�*a�)d�(h�'k�&n�%q�$t�#w�"z�!}� �� �� ��                                                                �      �� ��     0          (   0   `         �                        	

 !! ##"         		
	!! ""!$$#&&%   		
	

  ""!#$#%%$''&(('	
	

  !"!##"%%$''&(('**)	

 !! ##"$%$&&%(('**)++*	

!! "#"$$#&&%''&))(++*--,���		
	 ! ""!$$#%%$''&))(++*,,+..-���565		
	

  ""!##"%%$''&(('**),,+.-,//.������	
	

  !! ##"%%$&&%(('**)++*--,//.10/���������	

 !! ##"$$#&&%(('))(++*--,..-00/221������������		
	!! ""!$$#&&%''&))(++*,,+..-00/210332���������������		
	

  ""!#$#%%$''&(('**),,+..-//.110332543���������������ddd	
	

  !"!##"%%$''&(('**),,+--,//.110321443665������������������ddd	

 !! ##"$%$&&%(('**)++*--,/.-10/221443654776���������������������ddd	

!! "#"$$#&&%''&))(++*--,..-00/221432554776987������������������������ddd		
	 ! ""!$$#%%$''&))(++*,,+..-0/.110332554765887::9������������������������������		
	

  ""!##"%%$''&(('**),,+.-,//.110321443665887:98;;:���������������������������������	
	

  !! ##"%%$&&%(('**)++*--,//.10/221443665876998;;:=<;������������������������������������	

 !! ##"$$#&&%(('))(++*--,..-00/221432554776998;:9=<;>>=���������������������������������������676	
	!! ""!$$#&&%''&))(++*,,+..-00/210332554765987::9<<;>=<@?>~�����������������������������������������fgf  ""!#$#%%$''&(('**),,+..-//.110332543765887::9<;:>=<??>A@?0N�}��������������������������������������������  !"!##"%%$''&(('**),,+--,//.110321443665876:98;;:==<?>=A@?BBA/N�/O�c|�������������������������������������������>?> !! ##"$%$&&%(('**)++*--,/.-10/221443654776998;:9=<;>>=@@?BA@DCB/N�/P�/Q�Us����������������������������������������������!! "#"$$#&&%''&))(++*--,..-00/221432554776987::9<<;>=<@?>BA@CCBEED/O�/P�/Q�.R�;^����������������������������������������������RSR ! ""!$$#%%$''&))(++*,,+..-0/.110332554765887::9<;:>=<??>AA@CBAEDCGFE/O�/P�.Q�.R�.S�-Uϖ�����������������������������������������������++*  ""!##"%%$''&(('**),,+.-,//.110321443665887:98;;:==<??>A@?CBAEDCFFEHGF/P�/Q�.R�.S�.T�-U�-V�b����������������������������������������������񏏏//.##"%%$&&%(('**)++*--,//.10/221443665876998;;:=<;?>=A@?BBADCBFEDHGFJIH/P�/Q�.R�.S�.T�-U�-V�-W�9cբ�����������������������������������������������vvv&&%(('))(++*--,..-00/221432554776998;:9=<;>>=@@?BA@DCBFEDGFEIHGKJI/P�.Q�.R�.S�-U�-V�-W�,X�,Y�,Z�`��������������������������������������������������zzy887,,+..-00/210332554765987::9<<;>=<@?>BA@CCBEDCGFEIHGJJILKJ/Q�.R�.S�.T�-U�-V�-W�,X�,Y�,Z�+[�+\֕�������������������������������������������������򖖕<<;110332543765887::9<;:>=<??>A@?CBAEDCFFEHGFJIHLKJNML/Q�.R�.S�.T�-U�-V�-W�,Y�,Z�,[�+\�+]�+^�Esݯ�����������������������������������������������������ggf665876:98;;:==<?>=A@?BBADCBFEDHGFJIHKKJMLKONM.Q�.R�.S�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�Du������������������������������������������������������朜�TSR=<;>>=@@?BA@DCBFEDGGFIIHKJIMLKONMQPO.R�.S�.T�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�_���������������������������������������������������������ڔ��ZYXCCBEEDGFEIHGKJIMLKNMLPONRQP.R�.S�.T�-U�-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�Cy�����������������������������������������������������������箮����UUTLKJNMLPONRQPSRQ.R�.S�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)d�(e�(f�(g�'h�5r↫���������������������������������������������������������������ݲ�����ihgUTS.S�.T�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�\����������������������������������������������������������������������.S�.T�-U�-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'j�'k�&l�&m�&n�%o�i�������������������������������������������������������������.S�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)d�(e�(f�(g�'h�'i�'j�'k�&l�&m�&n�%o�%p�%q�$r�i����������������������������������������������������.T�-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�&l�&m�%n�%o�%q�$r�$s�$t�#u�#v�?��v�����������������������������������������.T�-U�-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'j�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"z�/��Y�����������������������������-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)c�(e�(f�(g�'h�'i�'j�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"z�"{�!|�!}�!~� � � ��<��X�����������-U�-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�&l�&m�%n�%o�%q�$r�$s�$t�#u�#v�#w�#x�"y�"z�"{�!|�!}�!~� � �� �� �� �� �� �� ��-U�-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"z�!{�!|�!}�!~� � �� �� �� �� �� �� ��-V�-W�,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)c�(e�(f�(g�'h�'i�'j�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"{�!|�!}�!~� � � �� �� �� �� �� �� ��-V�-W�,X�,Y�,Z�+[�+\�+]�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�&l�&m�%n�%o�%q�$r�$s�$t�$u�#v�#w�#x�"y�"z�"{�!|�!}�!~� � �� �� �� �� �� �� �� ��-V�-W�,X�,Z�,[�+\�+]�+^�*_�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"z�!{�!|�!}�!~� � �� �� �� �� �� �� �� ��   ,X�,Y�,Z�+[�+\�+]�*^�*_�*`�)a�)b�)c�(e�(f�(g�(h�'i�'j�'k�&l�&m�&n�%o�%p�%q�$r�$s�$t�#u�#v�#w�"x�"y�"z�!|�!}�!~� � � �� �� �� �� �� �� ��         ,Y�,Z�+[�+\�+]�*^�*`�*a�)b�)c�)d�(e�(f�(g�'h�'i�'j�&k�&l�&m�%n�%o�%p�$r�$s�$t�$u�#v�#w�#x�"y�"z�"{�!|�!}�!~� � �� �� �� �� �� �� ��      �      �                                                                                                                                                                                                                                                                                                                                                                      �      �      0   D   �� D X R I B B O N F O R M W I Z A R D         0                    �       h   00    �   