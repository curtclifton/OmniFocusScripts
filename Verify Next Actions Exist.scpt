FasdUAS 1.101.10   ��   ��    k             l      ��  ��   
+
%
	This script scans all projects and action groups in the front OmniFocus document identifying any that
	lack a next action.
	
	by Curt Clifton
	
	Copyright � 2007-2014, Curtis Clifton
	
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
	
		� Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
		
		� Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
		
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	
	verison 1.0: Updated for OmniFocus 2:
				� Added property to control whether single action lists are searched
				� Approximately twice as fast!
				� Uses Notification Center
				� Offers to reveal the projects and action groups that are missing next actions
				� Running the script again after added actions (or marking items completed) clears the �(missing next action)� suffix
				� Better error reporting
	version 0.5.1: Added a script to remove suffix to the package
	version 0.5: Move tag string to be a suffix rather than a prefix
	version 0.4.1: Removed sometimes-problematic use of 'activate' command
	version 0.4: Doesn't flag singleton holding projects as missing next actions even if they are empty
	version 0.3: Limited list of next-action-lacking projects in the dialog to 10.  More than 10 results in a dialog giving the number of such projects (along with the usual identifying-string instructions from the previous release).
	version 0.2: Added identifying string to offending projects based on idea from spiralocean.  Fixed bug where top-level projects without any actions were omitted.
	version 0.1: Original release
     � 	 	J 
 	 T h i s   s c r i p t   s c a n s   a l l   p r o j e c t s   a n d   a c t i o n   g r o u p s   i n   t h e   f r o n t   O m n i F o c u s   d o c u m e n t   i d e n t i f y i n g   a n y   t h a t 
 	 l a c k   a   n e x t   a c t i o n . 
 	 
 	 b y   C u r t   C l i f t o n 
 	 
 	 C o p y r i g h t   �   2 0 0 7 - 2 0 1 4 ,   C u r t i s   C l i f t o n 
 	 
 	 A l l   r i g h t s   r e s e r v e d . 
 	 
 	 R e d i s t r i b u t i o n   a n d   u s e   i n   s o u r c e   a n d   b i n a r y   f o r m s ,   w i t h   o r   w i t h o u t   m o d i f i c a t i o n ,   a r e   p e r m i t t e d   p r o v i d e d   t h a t   t h e   f o l l o w i n g   c o n d i t i o n s   a r e   m e t : 
 	 
 	 	 "   R e d i s t r i b u t i o n s   o f   s o u r c e   c o d e   m u s t   r e t a i n   t h e   a b o v e   c o p y r i g h t   n o t i c e ,   t h i s   l i s t   o f   c o n d i t i o n s   a n d   t h e   f o l l o w i n g   d i s c l a i m e r . 
 	 	 
 	 	 "   R e d i s t r i b u t i o n s   i n   b i n a r y   f o r m   m u s t   r e p r o d u c e   t h e   a b o v e   c o p y r i g h t   n o t i c e ,   t h i s   l i s t   o f   c o n d i t i o n s   a n d   t h e   f o l l o w i n g   d i s c l a i m e r   i n   t h e   d o c u m e n t a t i o n   a n d / o r   o t h e r   m a t e r i a l s   p r o v i d e d   w i t h   t h e   d i s t r i b u t i o n . 
 	 	 
 	 T H I S   S O F T W A R E   I S   P R O V I D E D   B Y   T H E   C O P Y R I G H T   H O L D E R S   A N D   C O N T R I B U T O R S   " A S   I S "   A N D   A N Y   E X P R E S S   O R   I M P L I E D   W A R R A N T I E S ,   I N C L U D I N G ,   B U T   N O T   L I M I T E D   T O ,   T H E   I M P L I E D   W A R R A N T I E S   O F   M E R C H A N T A B I L I T Y   A N D   F I T N E S S   F O R   A   P A R T I C U L A R   P U R P O S E   A R E   D I S C L A I M E D .   I N   N O   E V E N T   S H A L L   T H E   C O P Y R I G H T   O W N E R   O R   C O N T R I B U T O R S   B E   L I A B L E   F O R   A N Y   D I R E C T ,   I N D I R E C T ,   I N C I D E N T A L ,   S P E C I A L ,   E X E M P L A R Y ,   O R   C O N S E Q U E N T I A L   D A M A G E S   ( I N C L U D I N G ,   B U T   N O T   L I M I T E D   T O ,   P R O C U R E M E N T   O F   S U B S T I T U T E   G O O D S   O R   S E R V I C E S ;   L O S S   O F   U S E ,   D A T A ,   O R   P R O F I T S ;   O R   B U S I N E S S   I N T E R R U P T I O N )   H O W E V E R   C A U S E D   A N D   O N   A N Y   T H E O R Y   O F   L I A B I L I T Y ,   W H E T H E R   I N   C O N T R A C T ,   S T R I C T   L I A B I L I T Y ,   O R   T O R T   ( I N C L U D I N G   N E G L I G E N C E   O R   O T H E R W I S E )   A R I S I N G   I N   A N Y   W A Y   O U T   O F   T H E   U S E   O F   T H I S   S O F T W A R E ,   E V E N   I F   A D V I S E D   O F   T H E   P O S S I B I L I T Y   O F   S U C H   D A M A G E . 
 	 
 	 v e r i s o n   1 . 0 :   U p d a t e d   f o r   O m n i F o c u s   2 : 
 	 	 	 	 "   A d d e d   p r o p e r t y   t o   c o n t r o l   w h e t h e r   s i n g l e   a c t i o n   l i s t s   a r e   s e a r c h e d 
 	 	 	 	 "   A p p r o x i m a t e l y   t w i c e   a s   f a s t ! 
 	 	 	 	 "   U s e s   N o t i f i c a t i o n   C e n t e r 
 	 	 	 	 "   O f f e r s   t o   r e v e a l   t h e   p r o j e c t s   a n d   a c t i o n   g r o u p s   t h a t   a r e   m i s s i n g   n e x t   a c t i o n s 
 	 	 	 	 "   R u n n i n g   t h e   s c r i p t   a g a i n   a f t e r   a d d e d   a c t i o n s   ( o r   m a r k i n g   i t e m s   c o m p l e t e d )   c l e a r s   t h e    ( m i s s i n g   n e x t   a c t i o n )    s u f f i x 
 	 	 	 	 "   B e t t e r   e r r o r   r e p o r t i n g 
 	 v e r s i o n   0 . 5 . 1 :   A d d e d   a   s c r i p t   t o   r e m o v e   s u f f i x   t o   t h e   p a c k a g e 
 	 v e r s i o n   0 . 5 :   M o v e   t a g   s t r i n g   t o   b e   a   s u f f i x   r a t h e r   t h a n   a   p r e f i x 
 	 v e r s i o n   0 . 4 . 1 :   R e m o v e d   s o m e t i m e s - p r o b l e m a t i c   u s e   o f   ' a c t i v a t e '   c o m m a n d 
 	 v e r s i o n   0 . 4 :   D o e s n ' t   f l a g   s i n g l e t o n   h o l d i n g   p r o j e c t s   a s   m i s s i n g   n e x t   a c t i o n s   e v e n   i f   t h e y   a r e   e m p t y 
 	 v e r s i o n   0 . 3 :   L i m i t e d   l i s t   o f   n e x t - a c t i o n - l a c k i n g   p r o j e c t s   i n   t h e   d i a l o g   t o   1 0 .     M o r e   t h a n   1 0   r e s u l t s   i n   a   d i a l o g   g i v i n g   t h e   n u m b e r   o f   s u c h   p r o j e c t s   ( a l o n g   w i t h   t h e   u s u a l   i d e n t i f y i n g - s t r i n g   i n s t r u c t i o n s   f r o m   t h e   p r e v i o u s   r e l e a s e ) . 
 	 v e r s i o n   0 . 2 :   A d d e d   i d e n t i f y i n g   s t r i n g   t o   o f f e n d i n g   p r o j e c t s   b a s e d   o n   i d e a   f r o m   s p i r a l o c e a n .     F i x e d   b u g   w h e r e   t o p - l e v e l   p r o j e c t s   w i t h o u t   a n y   a c t i o n s   w e r e   o m i t t e d . 
 	 v e r s i o n   0 . 1 :   O r i g i n a l   r e l e a s e 
   
  
 l     ��������  ��  ��        j     �� �� <0 shouldchecksingleactionlists shouldCheckSingleActionLists  m     ��
�� boovfals      j    �� �� *0 lackinglistingdelim lackingListingDelim  l    ����  b        o    ��
�� 
ret   m       �            "  ��  ��        j    
�� �� "0 missingnasuffix missingNASuffix  m    	   �   * ( m i s s i n g   n e x t   a c t i o n )      j    �� �� (0 missingnadelimiter missingNADelimiter  m       �          ! " ! l     ��������  ��  ��   "  # $ # l      �� % &��   % D >
	The following properties are used for script notifications.
    & � ' ' | 
 	 T h e   f o l l o w i n g   p r o p e r t i e s   a r e   u s e d   f o r   s c r i p t   n o t i f i c a t i o n s . 
 $  ( ) ( j    �� *�� "0 scriptsuitename scriptSuiteName * m     + + � , ,  C u r t  s   S c r i p t s )  - . - l     ��������  ��  ��   .  / 0 / l   � 1���� 1 O    � 2 3 2 O   � 4 5 4 k   � 6 6  7 8 7 n    9 : 9 I    �� ;����  0 removesuffixes removeSuffixes ;  <�� <  g    ��  ��   :  f     8  = > = r      ? @ ? n    A B A I    �� C���� ,0 accumulatemissingnas accumulateMissingNAs C  D E D  g     E  F�� F J    ����  ��  ��   B  f     @ o      ���� (0 lackingnextactions lackingNextActions >  G�� G Z   !� H I�� J H l  ! % K���� K =  ! % L M L o   ! "���� (0 lackingnextactions lackingNextActions M J   " $����  ��  ��   I k   ( A N N  O P O Z   ( 9 Q R�� S Q o   ( -���� <0 shouldchecksingleactionlists shouldCheckSingleActionLists R r   0 3 T U T m   0 1 V V � W W � N e x t   a c t i o n s   a r e   i d e n t i f i e d   f o r   a l l   a c t i v e   p r o j e c t s ,   a c t i o n   g r o u p s ,   a n d   s i n g l e   a c t i o n   l i s t s . U o      ���� 0 msg  ��   S r   6 9 X Y X m   6 7 Z Z � [ [ � N e x t   a c t i o n s   a r e   i d e n t i f i e d   f o r   a l l   a c t i v e   p r o j e c t s   a n d   a c t i o n   g r o u p s . Y o      ���� 0 msg   P  \�� \ n  : A ] ^ ] I   ; A�� _���� 
0 notify   _  ` a ` m   ; < b b � c c   C o n g r a t u l a t i o n s ! a  d�� d o   < =���� 0 msg  ��  ��   ^  f   : ;��  ��   J k   D� e e  f g f r   D G h i h m   D E j j � k k � S o m e   a c t i v e   p r o j e c t s   o r   a c t i o n   g r o u p s   a r e   m i s s i n g   n e x t   a c t i o n s .   Y o u   c a n   r e v e a l   t h e m   i f   y o u   w a n t   t o   c o r r e c t   t h i s . i o      ���� 0 	titletext 	titleText g  l m l r   H K n o n m   H I p p � q q 
 i t e m s o o      ���� "0 pluralizeditems pluralizedItems m  r s r Z   L � t u v w t l  L S x���� x =  L S y z y l  L Q {���� { I  L Q�� |��
�� .corecnte****       **** | o   L M���� (0 lackingnextactions lackingNextActions��  ��  ��   z m   Q R���� ��  ��   u k   V r } }  ~  ~ r   V [ � � � m   V Y � � � � � � A n   a c t i v e   p r o j e c t   o r   a c t i o n   g r o u p   i s   m i s s i n g   a   n e x t   a c t i o n .   Y o u   c a n   r e v e a l   i t   i f   y o u   w a n t   t o   c o r r e c t   t h i s . � o      ���� 0 	titletext 	titleText   � � � r   \ l � � � b   \ j � � � b   \ f � � � m   \ _ � � � � � : T h e r e   i s   n o   n e x t   a c t i o n   f o r    � n   _ e � � � 4   ` e�� �
�� 
cobj � m   c d����  � o   _ `���� (0 lackingnextactions lackingNextActions � m   f i � � � � �   .   � o      ���� 0 msg   �  ��� � r   m r � � � m   m p � � � � �  i t e m � o      ���� "0 pluralizeditems pluralizedItems��   v  � � � l  u ~ ����� � ?   u ~ � � � l  u z ����� � I  u z�� ���
�� .corecnte****       **** � o   u v���� (0 lackingnextactions lackingNextActions��  ��  ��   � m   z }���� 
��  ��   �  ��� � r   � � � � � b   � � � � � l  � � ����� � I  � ��� ���
�� .corecnte****       **** � o   � ����� (0 lackingnextactions lackingNextActions��  ��  ��   � m   � � � � � � � t   a c t i v e   p r o j e c t s   o r   a c t i o n   g r o u p s   d o   n o t   h a v e   n e x t   a c t i o n s � o      ���� 0 msg  ��   w k   � � � �  � � � r   � � � � � n  � � � � � 1   � ���
�� 
txdl � 1   � ���
�� 
ascr � o      ���� 0 olddelim oldDelim �  � � � r   � � � � � o   � ����� *0 lackinglistingdelim lackingListingDelim � n      � � � 1   � ���
�� 
txdl � 1   � ���
�� 
ascr �  � � � r   � � � � � l  � � ����� � c   � � � � � o   � ����� (0 lackingnextactions lackingNextActions � m   � ���
�� 
ctxt��  ��   � o      ����  0 lackinglisting lackingListing �  � � � r   � � � � � o   � ����� 0 olddelim oldDelim � n      � � � 1   � ���
�� 
txdl � 1   � ���
�� 
ascr �  ��� � r   � � � � � b   � � � � � b   � � � � � b   � � � � � m   � � � � � � � � T h e s e   a c t i v e   p r o j e c t s   o r   a c t i o n   g r o u p s   d o   n o t   h a v e   n e x t   a c t i o n s : � o   � ����� *0 lackinglistingdelim lackingListingDelim � o   � �����  0 lackinglisting lackingListing � o   � ���
�� 
ret  � o      ���� 0 msg  ��   s  � � � r   �	 � � � I  ��� � �
�� .sysodisAaleR        TEXT � o   � ����� 0 	titletext 	titleText � �� � �
�� 
mesS � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � o   � ����� 0 msg   � m   � � � � � � �  M a r k   t h e   � o   � ����� "0 pluralizeditems pluralizedItems � m   � � � � � � � �   a s   c o m p l e t e d ,   o r   a d d   a c t i o n s   a s   n e e d e d   a n d   r e - r u n   t h i s   s c r i p t   t o   r e m o v e   t h e    � o   � ����� "0 missingnasuffix missingNASuffix � m   � � � � � � �     s u f f i x . � �� � �
�� 
btns � J   � � � �  � � � m   � � � � � � �  O K �  ��� � m   � � � � � � �  R e v e a l��   � �� � �
�� 
dflt � m   � �����  � �� ���
�� 
cbtn � m   � ����� ��   � o      ���� 0 alertresult alertResult �  ��� � Z  
� � ����� � l 
 ����� � = 
 � � � n  
 � � � 1  ��
�� 
bhit � o  
���� 0 alertresult alertResult � m   � � � � �  R e v e a l��  ��   � k  � � �  � � � r  6 �  � I 2����
�� .corecrel****      � null��   ��
�� 
kocl m  ��
�� 
FCdw ����
�� 
insh n  ", 8  (,��
�� 
insl 4 "(��
�� 
FCdw m  &'���� ��    o      ���� 0 awindow aWindow � � O  7�	
	 k  =�  r  =F m  =@�~
�~ FCsbFCT1 1  @E�}
�} 
FCST  r  GX m  GJ�|
�| savono   n       1  SW�{
�{ 
OTs? n  JS 2  OS�z
�z 
OTds 1  JO�y
�y 
FCSt  r  Yf m  Y\ �  i n c o m p l e t e n       1  ae�x
�x 
FC?i 1  \a�w
�w 
FCcn  !  r  gp"#" 1  gl�v
�v 
FC~=# o      �u�u &0 currentsearchterm currentSearchTerm! $�t$ Z  q�%&�s'% l qx(�r�q( = qx)*) o  qt�p�p &0 currentsearchterm currentSearchTerm* m  tw�o
�o 
msng�r  �q  & I {��n+,
�n .sysodisAaleR        TEXT+ m  {~-- �.. � T h e   m i s s i n g   a c t i o n s   c a n n o t   b e   r e v e a l e d   w i t h o u t   h a v i n g   t h e   S e a r c h   f i e l d   i n   t h e   t o o l b a r ., �m/0
�m 
mesS/ m  ��11 �22b T o   a d d   t h e   S e a r c h   f i e l d ,   c o n t r o l - c l i c k   o n   t h e   t o o l b a r ,   c h o o s e    C u s t o m i z e   T o o l b a r &  ,   a n d   d r a g   t h e   S e a r c h   f i e l d   o n t o   t h e   t o o l b a r .   R e - r u n   t h i s   s c r i p t   t o   r e v e a l   t h e   m i s s i n g   a c t i o n s .0 �l3�k
�l 
btns3 J  ��44 5�j5 m  ��66 �77  O K�j  �k  �s  ' r  ��898 m  ��:: �;; * ( m i s s i n g   n e x t   a c t i o n )9 1  ���i
�i 
FC~=�t  
 o  7:�h�h 0 awindow aWindow�  ��  ��  ��  ��   5 4   �g<
�g 
docu< m   
 �f�f  3 5     �e=�d
�e 
capp= m    >> �?? 0 c o m . o m n i g r o u p . O m n i F o c u s 2
�d kfrmID  ��  ��   0 @A@ l     �c�b�a�c  �b  �a  A BCB l      �`DE�`  D	 
	Accumulates a list of items that are:
		� not complete and 
		� have subtasks, but 
		� have no incomplete or pending subtasks.
	theContainer: a document or folder containing flattened projects
	accum: the items lacking next actions that have been found so far 
   E �FF   
 	 A c c u m u l a t e s   a   l i s t   o f   i t e m s   t h a t   a r e : 
 	 	 "   n o t   c o m p l e t e   a n d   
 	 	 "   h a v e   s u b t a s k s ,   b u t   
 	 	 "   h a v e   n o   i n c o m p l e t e   o r   p e n d i n g   s u b t a s k s . 
 	 t h e C o n t a i n e r :   a   d o c u m e n t   o r   f o l d e r   c o n t a i n i n g   f l a t t e n e d   p r o j e c t s 
 	 a c c u m :   t h e   i t e m s   l a c k i n g   n e x t   a c t i o n s   t h a t   h a v e   b e e n   f o u n d   s o   f a r   
C GHG i    IJI I      �_K�^�_ ,0 accumulatemissingnas accumulateMissingNAsK LML o      �]�] 0 thecontainer theContainerM N�\N o      �[�[ 	0 accum  �\  �^  J k     COO PQP I    �ZR�Y
�Z .ascrcmnt****      � ****R o     �X�X 0 thecontainer theContainer�Y  Q S�WS w    CTUT k    CVV WXW Z    9YZ�V[Y o    �U�U <0 shouldchecksingleactionlists shouldCheckSingleActionListsZ r    \]\ 6   ^_^ n    `a` 2    �T
�T 
FCfxa o    �S�S 0 thecontainer theContainer_ =   bcb 1    �R
�R 
FCPsc m    �Q
�Q FCPsFCPa] o      �P�P 0 theprojects theProjects�V  [ r   ! 9ded 6  ! 7fgf n   ! $hih 2   " $�O
�O 
FCfxi o   ! "�N�N 0 thecontainer theContainerg F   % 6jkj =  & -lml 1   ' )�M
�M 
FCPsm m   * ,�L
�L FCPsFCPak =  . 5non 1   / 1�K
�K 
FC.Ao m   2 4�J
�J boovfalse o      �I�I 0 theprojects theProjectsX p�Hp r   : Cqrq n  : Asts I   ; A�Gu�F�G <0 accumulatemissingnasprojects accumulateMissingNAsProjectsu vwv o   ; <�E�E 0 theprojects theProjectsw x�Dx o   < =�C�C 	0 accum  �D  �F  t  f   : ;r o      �B�B 	0 accum  �H  U�                                                                                  OFOC  alis    X  Macintosh HD               �Ȗ�H+   �G�OmniFocus.app                                                  x	�ϛ��        ����  	                Applications    ���*      ϜGV     �G�  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  �W  H yzy l     �A�@�?�A  �@  �?  z {|{ l      �>}~�>  }$ 
	Recurses over the trees rooted at the given projects, accumulates a list of items that are:
		� not complete and 
		� have subtasks, but 
		� have no incomplete or pending subtasks.
	theProjects: a list of projects
	accum: the items lacking next actions that have been found so far 
   ~ �<   
 	 R e c u r s e s   o v e r   t h e   t r e e s   r o o t e d   a t   t h e   g i v e n   p r o j e c t s ,   a c c u m u l a t e s   a   l i s t   o f   i t e m s   t h a t   a r e : 
 	 	 "   n o t   c o m p l e t e   a n d   
 	 	 "   h a v e   s u b t a s k s ,   b u t   
 	 	 "   h a v e   n o   i n c o m p l e t e   o r   p e n d i n g   s u b t a s k s . 
 	 t h e P r o j e c t s :   a   l i s t   o f   p r o j e c t s 
 	 a c c u m :   t h e   i t e m s   l a c k i n g   n e x t   a c t i o n s   t h a t   h a v e   b e e n   f o u n d   s o   f a r   
| ��� i    ��� I      �=��<�= <0 accumulatemissingnasprojects accumulateMissingNAsProjects� ��� o      �;�; 0 theprojects theProjects� ��:� o      �9�9 	0 accum  �:  �<  � k     ^�� ��� w     [��� X    [��8�� k    V�� ��� I   �7��6
�7 .ascrcmnt****      � ****� b    ��� m    �� ��� $ C h e c k i n g   p r o j e c t :  � l   ��5�4� n    ��� 1    �3
�3 
pnam� o    �2�2 0 aproject aProject�5  �4  �6  � ��� r    !��� n    ��� 1    �1
�1 
ctnr� o    �0�0 0 aproject aProject� o      �/�/ $0 projectcontainer projectContainer� ��.� Z   " V���-�� l  " ;��,�+� G   " ;��� >  " '��� n   " %��� m   # %�*
�* 
pcls� o   " #�)�) $0 projectcontainer projectContainer� m   % &�(
�( 
FCAr� l  * 9��'�&� F   * 9��� =  * /��� n   * -��� m   + -�%
�% 
pcls� o   * +�$�$ $0 projectcontainer projectContainer� m   - .�#
�# 
FCAr� >  2 7��� n   2 5��� 1   3 5�"
�" 
FCHi� o   2 3�!�! $0 projectcontainer projectContainer� m   5 6� 
�  boovtrue�'  �&  �,  �+  � k   > N�� ��� r   > C��� n   > A��� 1   ? A�
� 
FCrt� o   > ?�� 0 aproject aProject� o      �� 0 theroottask theRootTask� ��� r   D N��� n  D L��� I   E L���� 40 accumulatemissingnastask accumulateMissingNAsTask� ��� o   E F�� 0 theroottask theRootTask� ��� m   F G�
� boovtrue� ��� o   G H�� 	0 accum  �  �  �  f   D E� o      �� 	0 accum  �  �-  � I  Q V���
� .ascrcmnt****      � ****� m   Q R�� ���  s k i p p e d�  �.  �8 0 aproject aProject� o    �� 0 theprojects theProjects��                                                                                  OFOC  alis    X  Macintosh HD               �Ȗ�H+   �G�OmniFocus.app                                                  x	�ϛ��        ����  	                Applications    ���*      ϜGV     �G�  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  � ��� L   \ ^�� o   \ ]�� 	0 accum  �  � ��� l     ����  �  �  � ��� l      ����  �NH 
	Recurses over the tree rooted at the given task, accumulates a list of items that are:
		� not complete and 
		� have subtasks, but 
		� have no incomplete or pending subtasks.
	theTask: a task
	isProjectRoot: true iff theTask is the root task of a project
	accum: the items lacking next actions that have been found so far 
   � ����   
 	 R e c u r s e s   o v e r   t h e   t r e e   r o o t e d   a t   t h e   g i v e n   t a s k ,   a c c u m u l a t e s   a   l i s t   o f   i t e m s   t h a t   a r e : 
 	 	 "   n o t   c o m p l e t e   a n d   
 	 	 "   h a v e   s u b t a s k s ,   b u t   
 	 	 "   h a v e   n o   i n c o m p l e t e   o r   p e n d i n g   s u b t a s k s . 
 	 t h e T a s k :   a   t a s k 
 	 i s P r o j e c t R o o t :   t r u e   i f f   t h e T a s k   i s   t h e   r o o t   t a s k   o f   a   p r o j e c t 
 	 a c c u m :   t h e   i t e m s   l a c k i n g   n e x t   a c t i o n s   t h a t   h a v e   b e e n   f o u n d   s o   f a r   
� ��� i    ��� I      ���
� 40 accumulatemissingnastask accumulateMissingNAsTask� ��� o      �	�	 0 thetask theTask� ��� o      �� 0 isprojectroot isProjectRoot� ��� o      �� 	0 accum  �  �
  � w     ���� O    ���� k    ��� ��� r    ��� G    ��� o    �� 0 isprojectroot isProjectRoot� ?   
 ��� l  
 ���� I  
 ���
� .corecnte****       ****� l  
 �� ��� e   
 �� 2  
 ��
�� 
FCac�   ��  �  �  �  � m    ����  � o      ���� 80 isaprojectorsubprojecttask isAProjectOrSubprojectTask� ��� Z   -������� l   $������ G    $��� 1    ��
�� 
FCcd� H     "�� o     !���� 80 isaprojectorsubprojecttask isAProjectOrSubprojectTask��  ��  � L   ' )�� o   ' (���� 	0 accum  ��  ��  � ��� r   . <��� 6  . :��� 2   . 1��
�� 
FCac� =  2 9��� 1   3 5��
�� 
FCcd� m   6 8��
�� boovfals� o      ���� ,0 incompletechildtasks incompleteChildTasks�  ��  Z   = ��� l  = D���� =  = D l  = B���� I  = B����
�� .corecnte****       **** o   = >���� ,0 incompletechildtasks incompleteChildTasks��  ��  ��   m   B C����  ��  ��   k   G u		 

 r   G M 1   G J��
�� 
pnam n        ;   K L o   J K���� 	0 accum    l  N N����   � � The following idea of tagging the items with an identifying string is due to user spiralocean on the OmniFocus Extras forum at OmniGroup.com:    �   T h e   f o l l o w i n g   i d e a   o f   t a g g i n g   t h e   i t e m s   w i t h   a n   i d e n t i f y i n g   s t r i n g   i s   d u e   t o   u s e r   s p i r a l o c e a n   o n   t h e   O m n i F o c u s   E x t r a s   f o r u m   a t   O m n i G r o u p . c o m :  Z   N r���� l  N X���� H   N X D   N W 1   N Q��
�� 
pnam o   Q V���� "0 missingnasuffix missingNASuffix��  ��   r   [ n l  [ j���� b   [ j !  b   [ d"#" 1   [ ^��
�� 
pnam# o   ^ c���� (0 missingnadelimiter missingNADelimiter! o   d i���� "0 missingnasuffix missingNASuffix��  ��   1   j m��
�� 
pnam��  ��   $��$ L   s u%% o   s t���� 	0 accum  ��  ��   L   x �&& n  x '(' I   y ��)���� 60 accumulatemissingnastasks accumulateMissingNAsTasks) *+* o   y z���� ,0 incompletechildtasks incompleteChildTasks+ ,��, o   z {���� 	0 accum  ��  ��  (  f   x y��  � o    ���� 0 thetask theTask��                                                                                  OFOC  alis    X  Macintosh HD               �Ȗ�H+   �G�OmniFocus.app                                                  x	�ϛ��        ����  	                Applications    ���*      ϜGV     �G�  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  � -.- l     ��������  ��  ��  . /0/ l      ��12��  1A; 
	Recurses over the trees rooted at the given tasks, accumulates a list of items that are:
		� not complete and 
		� have subtasks, but 
		� have no incomplete or pending subtasks.
	theTasks: a list of tasks, none of which are project root tasks
	accum: the items lacking next actions that have been found so far 
   2 �33v   
 	 R e c u r s e s   o v e r   t h e   t r e e s   r o o t e d   a t   t h e   g i v e n   t a s k s ,   a c c u m u l a t e s   a   l i s t   o f   i t e m s   t h a t   a r e : 
 	 	 "   n o t   c o m p l e t e   a n d   
 	 	 "   h a v e   s u b t a s k s ,   b u t   
 	 	 "   h a v e   n o   i n c o m p l e t e   o r   p e n d i n g   s u b t a s k s . 
 	 t h e T a s k s :   a   l i s t   o f   t a s k s ,   n o n e   o f   w h i c h   a r e   p r o j e c t   r o o t   t a s k s 
 	 a c c u m :   t h e   i t e m s   l a c k i n g   n e x t   a c t i o n s   t h a t   h a v e   b e e n   f o u n d   s o   f a r   
0 454 i     676 I      ��8���� 60 accumulatemissingnastasks accumulateMissingNAsTasks8 9:9 o      ���� 0 thetasks theTasks: ;��; o      ���� 	0 accum  ��  ��  7 k     $<< =>= w     !?@? X    !A��BA r    CDC n   EFE I    ��G���� 40 accumulatemissingnastask accumulateMissingNAsTaskG HIH o    ���� 0 atask aTaskI JKJ m    ��
�� boovfalsK L��L o    ���� 	0 accum  ��  ��  F  f    D o      ���� 	0 accum  �� 0 atask aTaskB o    ���� 0 thetasks theTasks@�                                                                                  OFOC  alis    X  Macintosh HD               �Ȗ�H+   �G�OmniFocus.app                                                  x	�ϛ��        ����  	                Applications    ���*      ϜGV     �G�  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  > M��M L   " $NN o   " #���� 	0 accum  ��  5 OPO l     ��������  ��  ��  P QRQ l      ��ST��  S p j
	Removes "missing next action" suffixes from all tasks and projects.
	theDocument: an OmniFocus document
   T �UU � 
 	 R e m o v e s   " m i s s i n g   n e x t   a c t i o n "   s u f f i x e s   f r o m   a l l   t a s k s   a n d   p r o j e c t s . 
 	 t h e D o c u m e n t :   a n   O m n i F o c u s   d o c u m e n t 
R VWV i   ! $XYX I      ��Z����  0 removesuffixes removeSuffixesZ [��[ o      ���� 0 thedocument theDocument��  ��  Y w     q\]\ k    q^^ _`_ r    aba 6   cdc n    efe 2    ��
�� 
FCftf o    ���� 0 thedocument theDocumentd D    ghg 1    	��
�� 
pnamh o   
 ���� "0 missingnasuffix missingNASuffixb o      ���� 0 thetasks theTasks` i��i X    qj��kj k   % lll mnm r   % *opo n   % (qrq 1   & (��
�� 
pnamr o   % &���� 0 atask aTaskp o      ���� 0 newname newNamen sts r   + Auvu n   + ?wxw 7  , ?��yz
�� 
ctxty m   0 2���� z d   3 >{{ l  4 =|����| [   4 =}~} m   4 5���� ~ l  5 <���� n   5 <��� 1   : <��
�� 
leng� o   5 :���� "0 missingnasuffix missingNASuffix��  ��  ��  ��  x o   + ,���� 0 newname newNamev o      ���� 0 newname newNamet ��� Z   B f������� l  B I������ D   B I��� o   B C���� 0 newname newName� o   C H���� (0 missingnadelimiter missingNADelimiter��  ��  � r   L b��� n   L `��� 7  M `����
�� 
ctxt� m   Q S���� � d   T _�� l  U ^������ [   U ^��� m   U V���� � l  V ]������ n   V ]��� 1   [ ]��
�� 
leng� o   V [���� (0 missingnadelimiter missingNADelimiter��  ��  ��  ��  � o   L M���� 0 newname newName� o      ���� 0 newname newName��  ��  � ���� r   g l��� o   g h���� 0 newname newName� n      ��� 1   i k��
�� 
pnam� o   h i���� 0 atask aTask��  �� 0 atask aTaskk o    ���� 0 thetasks theTasks��  ]�                                                                                  OFOC  alis    X  Macintosh HD               �Ȗ�H+   �G�OmniFocus.app                                                  x	�ϛ��        ����  	                Applications    ���*      ϜGV     �G�  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��  W ��� l     ��������  ��  ��  � ��� l      ������  � � �
	Uses Notification Center to display a notification message.
	theTitle � a string giving the notification title
	theDescription � a string describing the notification event
   � ���\ 
 	 U s e s   N o t i f i c a t i o n   C e n t e r   t o   d i s p l a y   a   n o t i f i c a t i o n   m e s s a g e . 
 	 t h e T i t l e      a   s t r i n g   g i v i n g   t h e   n o t i f i c a t i o n   t i t l e 
 	 t h e D e s c r i p t i o n      a   s t r i n g   d e s c r i b i n g   t h e   n o t i f i c a t i o n   e v e n t 
� ��� i   % (��� I      ������� 
0 notify  � ��� o      ���� 0 thetitle theTitle� ���� o      ����  0 thedescription theDescription��  ��  � I    ���
� .sysonotfnull��� ��� TEXT� o     �~�~  0 thedescription theDescription� �}��
�} 
appr� o    �|�| "0 scriptsuitename scriptSuiteName� �{��z
�{ 
subt� o    	�y�y 0 thetitle theTitle�z  � ��x� l     �w�v�u�w  �v  �u  �x       �t��s�   +��������t  � �r�q�p�o�n�m�l�k�j�i�h�g�r <0 shouldchecksingleactionlists shouldCheckSingleActionLists�q *0 lackinglistingdelim lackingListingDelim�p "0 missingnasuffix missingNASuffix�o (0 missingnadelimiter missingNADelimiter�n "0 scriptsuitename scriptSuiteName�m ,0 accumulatemissingnas accumulateMissingNAs�l <0 accumulatemissingnasprojects accumulateMissingNAsProjects�k 40 accumulatemissingnastask accumulateMissingNAsTask�j 60 accumulatemissingnastasks accumulateMissingNAsTasks�i  0 removesuffixes removeSuffixes�h 
0 notify  
�g .aevtoappnull  �   � ****
�s boovfals� ���           "  � �fJ�e�d���c�f ,0 accumulatemissingnas accumulateMissingNAs�e �b��b �  �a�`�a 0 thecontainer theContainer�` 	0 accum  �d  � �_�^�]�_ 0 thecontainer theContainer�^ 	0 accum  �] 0 theprojects theProjects� �\U�[��Z�Y�X�W
�\ .ascrcmnt****      � ****
�[ 
FCfx�  
�Z 
FCPs
�Y FCPsFCPa
�X 
FC.A�W <0 accumulatemissingnasprojects accumulateMissingNAsProjects�c D�j  O�Zb    ��-�[�,\Z�81E�Y ��-�[[�,\Z�8\[�,\Zf8A1E�O)��l+ E�� �V��U�T���S�V <0 accumulatemissingnasprojects accumulateMissingNAsProjects�U �R��R �  �Q�P�Q 0 theprojects theProjects�P 	0 accum  �T  � �O�N�M�L�K�O 0 theprojects theProjects�N 	0 accum  �M 0 aproject aProject�L $0 projectcontainer projectContainer�K 0 theroottask theRootTask� ��J�I�H��G�F�E�D�C�B�A�@�?�
�J 
kocl
�I 
cobj
�H .corecnte****       ****
�G 
pnam
�F .ascrcmnt****      � ****
�E 
ctnr
�D 
pcls
�C 
FCAr
�B 
FCHi
�A 
bool
�@ 
FCrt�? 40 accumulatemissingnastask accumulateMissingNAsTask�S _�Z X�[��l kh ��,%j O��,E�O��,�
 ��,� 	 	��,e�&�& ��,E�O)�e�m+ E�Y �j [OY��O�� �>��=�<���;�> 40 accumulatemissingnastask accumulateMissingNAsTask�= �:��: �  �9�8�7�9 0 thetask theTask�8 0 isprojectroot isProjectRoot�7 	0 accum  �<  � �6�5�4�3�2�6 0 thetask theTask�5 0 isprojectroot isProjectRoot�4 	0 accum  �3 80 isaprojectorsubprojecttask isAProjectOrSubprojectTask�2 ,0 incompletechildtasks incompleteChildTasks� ��1�0�/�.��-�,
�1 
FCac
�0 .corecnte****       ****
�/ 
bool
�. 
FCcd
�- 
pnam�, 60 accumulatemissingnastasks accumulateMissingNAsTasks�; ��Z� |�
 *�-Ej j�&E�O*�,E
 ��& �Y hO*�-�[�,\Zf81E�O�j j  3*�,�6FO*�,b   *�,b  %b  %*�,FY hO�Y 
)��l+ U� �+7�*�)���(�+ 60 accumulatemissingnastasks accumulateMissingNAsTasks�* �'��' �  �&�%�& 0 thetasks theTasks�% 	0 accum  �)  � �$�#�"�$ 0 thetasks theTasks�# 	0 accum  �" 0 atask aTask� @�!� ��
�! 
kocl
�  
cobj
� .corecnte****       ****� 40 accumulatemissingnastask accumulateMissingNAsTask�( %�Z �[��l kh )�f�m+ E�[OY��O�� �Y������  0 removesuffixes removeSuffixes� ��� �  �� 0 thedocument theDocument�  � ����� 0 thedocument theDocument� 0 thetasks theTasks� 0 atask aTask� 0 newname newName� 	]��������
� 
FCft
� 
pnam
� 
kocl
� 
cobj
� .corecnte****       ****
� 
ctxt
� 
leng� r�Z��-�[�,\Zb  ?1E�O [�[��l kh ��,E�O�[�\[Zk\Zkb  �,'2E�O�b   �[�\[Zk\Zkb  �,'2E�Y hO���,F[OY��� ����
���	� 
0 notify  � ��� �  ��� 0 thetitle theTitle�  0 thedescription theDescription�
  � ��� 0 thetitle theTitle�  0 thedescription theDescription� ���� 
� 
appr
� 
subt� 
�  .sysonotfnull��� ��� TEXT�	 ��b  �� � �����������
�� .aevtoappnull  �   � ****� k    ���  /����  ��  ��  �  � D��>���������� V�� Z b�� j�� p���� � ��� � ��� ����������� ����� � � ��� � ������������� �������������������������������������-16:
�� 
capp
�� kfrmID  
�� 
docu��  0 removesuffixes removeSuffixes�� ,0 accumulatemissingnas accumulateMissingNAs�� (0 lackingnextactions lackingNextActions�� 0 msg  �� 
0 notify  �� 0 	titletext 	titleText�� "0 pluralizeditems pluralizedItems
�� .corecnte****       ****
�� 
cobj�� 

�� 
ascr
�� 
txdl�� 0 olddelim oldDelim
�� 
ctxt��  0 lackinglisting lackingListing
�� 
ret 
�� 
mesS
�� 
btns
�� 
dflt
�� 
cbtn�� 
�� .sysodisAaleR        TEXT�� 0 alertresult alertResult
�� 
bhit
�� 
kocl
�� 
FCdw
�� 
insh
�� 
insl�� 
�� .corecrel****      � null�� 0 awindow aWindow
�� FCsbFCT1
�� 
FCST
�� savono  
�� 
FCSt
�� 
OTds
�� 
OTs?
�� 
FCcn
�� 
FC?i
�� 
FC~=�� &0 currentsearchterm currentSearchTerm
�� 
msng���)���0�*�k/�)*k+ O)*jvl+ E�O�jv  b    �E�Y �E�O)��l+ Ya�E�O�E�O�j k  !a E�Oa �a k/%a %E�Oa E�Y _�j a  �j a %E�Y E_ a ,E` Ob  _ a ,FO�a &E` O_ _ a ,FOa b  %_ %_ %E�O�a �a  %�%a !%b  %a "%a #a $a %lva &la 'ka ( )E` *O_ *a +,a ,  �*a -a .a /*a .k/a 03a 1 2E` 3O_ 3 ca 4*a 5,FOa 6*a 7,a 8-a 9,FOa :*a ;,a <,FO*a =,E` >O_ >a ?  a @a a Aa #a Bkva 1 )Y a C*a =,FUY hUUascr  ��ޭ