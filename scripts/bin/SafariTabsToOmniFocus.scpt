FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��
Safari URLs List to OmniFocus Inbox as Individual Tasks
Copyright (C) 2013 David Nunez (www.davidnunez.com)

This script takes every tab in Safari and creates a brand new task in OmniFocus inbox with the tab title as the task name and the url as the task note.

It then closes this tab.

When all tabs are closed, the script posts a growl notification.

Derived from these scripts:

- http://veritrope.com/code/export-all-safari-tabs-to-evernote/
- http://veritrope.com/code/safari-tab-list-to-omnifocus
- http://shawnblanc.net/2012/08/frontmost-safari-tabs-omnifocus/
- [closing tabs - note the countdown from number of tabs to 1] http://stackoverflow.com/questions/2503372/how-to-close-all-or-only-some-tabs-in-safari-using-applescript
     � 	 	� 
 S a f a r i   U R L s   L i s t   t o   O m n i F o c u s   I n b o x   a s   I n d i v i d u a l   T a s k s 
 C o p y r i g h t   ( C )   2 0 1 3   D a v i d   N u n e z   ( w w w . d a v i d n u n e z . c o m ) 
 
 T h i s   s c r i p t   t a k e s   e v e r y   t a b   i n   S a f a r i   a n d   c r e a t e s   a   b r a n d   n e w   t a s k   i n   O m n i F o c u s   i n b o x   w i t h   t h e   t a b   t i t l e   a s   t h e   t a s k   n a m e   a n d   t h e   u r l   a s   t h e   t a s k   n o t e . 
 
 I t   t h e n   c l o s e s   t h i s   t a b . 
 
 W h e n   a l l   t a b s   a r e   c l o s e d ,   t h e   s c r i p t   p o s t s   a   g r o w l   n o t i f i c a t i o n . 
 
 D e r i v e d   f r o m   t h e s e   s c r i p t s : 
 
 -   h t t p : / / v e r i t r o p e . c o m / c o d e / e x p o r t - a l l - s a f a r i - t a b s - t o - e v e r n o t e / 
 -   h t t p : / / v e r i t r o p e . c o m / c o d e / s a f a r i - t a b - l i s t - t o - o m n i f o c u s 
 -   h t t p : / / s h a w n b l a n c . n e t / 2 0 1 2 / 0 8 / f r o n t m o s t - s a f a r i - t a b s - o m n i f o c u s / 
 -   [ c l o s i n g   t a b s   -   n o t e   t h e   c o u n t d o w n   f r o m   n u m b e r   o f   t a b s   t o   1 ]   h t t p : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 2 5 0 3 3 7 2 / h o w - t o - c l o s e - a l l - o r - o n l y - s o m e - t a b s - i n - s a f a r i - u s i n g - a p p l e s c r i p t 
   
  
 l     ��������  ��  ��        l     ����  r         J     ����    o      ���� 0 tabs_to_close  ��  ��        l    ����  r        l    ����  c        l   
 ����  l   
 ����  I   
������
�� .misccurdldt    ��� null��  ��  ��  ��  ��  ��    m   
 ��
�� 
TEXT��  ��    l      ����  o      ���� 0 
date_stamp  ��  ��  ��  ��        l    ����  r         b     ! " ! m     # # � $ $ : U R L   L i s t   f r o m   S a f a r i   T a b s   o n   " l    %���� % o    ���� 0 
date_stamp  ��  ��     o      ���� 0 	notetitle 	NoteTitle��  ��     & ' & l   � (���� ( O    � ) * ) k    � + +  , - , I   ������
�� .miscactvnull��� ��� null��  ��   -  . / . r    % 0 1 0 4    #�� 2
�� 
cwin 2 m   ! "����  1 o      ���� 0 safariwindow safariWindow /  3�� 3 Q   & � 4 5�� 4 k   ) � 6 6  7 8 7 I  ) .�� 9��
�� .ascrcmnt****      � **** 9 m   ) * : : � ; ;  2��   8  < = < l  / /��������  ��  ��   =  > ? > Y   / � @�� A B C @ k   ? � D D  E F E I  ? J�� G��
�� .ascrcmnt****      � **** G l  ? F H���� H I  ? F�� I��
�� .corecnte****       **** I n   ? B J K J 2  @ B��
�� 
bTab K o   ? @���� 0 safariwindow safariWindow��  ��  ��  ��   F  L M L r   K Q N O N n   K O P Q P 4   L O�� R
�� 
bTab R o   M N���� 0 j   Q o   K L���� 0 safariwindow safariWindow O o      ���� 0 t   M  S T S l  R R��������  ��  ��   T  U V U l  R R�� W X��   W - 'repeat with t in (tabs of safariWindow)    X � Y Y N r e p e a t   w i t h   t   i n   ( t a b s   o f   s a f a r i W i n d o w ) V  Z [ Z r   R Y \ ] \ l  R U ^���� ^ n   R U _ ` _ 1   S U��
�� 
pnam ` o   R S���� 0 t  ��  ��   ] o      ���� 0 tabtitle TabTitle [  a b a r   Z c c d c l  Z _ e���� e n   Z _ f g f 1   [ _��
�� 
pURL g o   Z [���� 0 t  ��  ��   d o      ���� 0 taburl TabURL b  h i h r   d  j k j l  d { l���� l b   d { m n m b   d w o p o b   d s q r q b   d o s t s b   d k u v u m   d g w w � x x   v o   g j���� 0 tabtitle TabTitle t o   k n��
�� 
ret  r o   o r���� 0 taburl TabURL p o   s v��
�� 
ret  n o   w z��
�� 
ret ��  ��   k o      ���� 0 tabinfo TabInfo i  y z y O   � � { | { I  � ����� }
�� .corecrel****      � null��   } �� ~ 
�� 
kocl ~ m   � ���
�� 
FCit  �� ���
�� 
prdt � K   � � � � �� � �
�� 
pnam � l  � � ����� � o   � ����� 0 tabtitle TabTitle��  ��   � �� ���
�� 
FCno � o   � ����� 0 taburl TabURL��  ��   | n   � � � � � 4  � ��� �
�� 
docu � m   � �����  � m   � � � ��                                                                                  OFOC  alis    X  Macintosh HD               �0ڲH+     OOmniFocus.app                                                   r�̥��        ����  	                Applications    �1�      ̦(       O  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��   z  ��� � I  � ��� ���
�� .coreclosnull���    obj  � o   � ����� 0 t  ��  ��  �� 0 j   A l  2 9 ����� � I  2 9�� ���
�� .corecnte****       **** � n   2 5 � � � 2  3 5��
�� 
bTab � o   2 3���� 0 safariwindow safariWindow��  ��  ��   B m   9 :����  C m   : ;������ ?  ��� � l  � ���������  ��  ��  ��   5 R      ������
�� .ascrerr ****      � ****��  ��  ��  ��   * m     � ��                                                                                  sfri  alis    N  Macintosh HD               �0ڲH+     O
Safari.app                                                       Q�~�J        ����  	                Applications    �1�      �6�       O  %Macintosh HD:Applications: Safari.app    
 S a f a r i . a p p    M a c i n t o s h   H D  Applications/Safari.app   / ��  ��  ��   '  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l  �" ����� � O   �" � � � k   �! � �  � � � r   � � � � � J   � � � �  � � � m   � � � � � � � ( S u c c e s s   N o t i f i c a t i o n �  ��� � m   � � � � � � � ( F a i l u r e   N o t i f i c a t i o n��   � l      ����� � o      ���� ,0 allnotificationslist allNotificationsList��  ��   �  � � � r   � � � � � J   � � � �  � � � m   � � � � � � � ( S u c c e s s   N o t i f i c a t i o n �  ��� � m   � � � � � � � ( F a i l u r e   N o t i f i c a t i o n��   � l      ���� � o      �~�~ 40 enablednotificationslist enabledNotificationsList��  �   �  � � � l  � ��}�|�{�}  �|  �{   �  � � � I  ��z�y �
�z .registernull��� ��� null�y   � �x � �
�x 
appl � l 	 � � ��w�v � m   � � � � � � � > S a f a r i   T a b s   t o   O m n i F o c u s   S c r i p t�w  �v   � �u � �
�u 
anot � l 
 � � ��t�s � o   � ��r�r ,0 allnotificationslist allNotificationsList�t  �s   � �q � �
�q 
dnot � l 
 � � ��p�o � o   � ��n�n 40 enablednotificationslist enabledNotificationsList�p  �o   � �m ��l
�m 
iapp � m   � � � � � � �  S a f a r i�l   �  � � � l �k�j�i�k  �j  �i   �  ��h � I !�g�f �
�g .notifygrnull��� ��� null�f   � �e � �
�e 
name � l 		 ��d�c � m  	 � � � � � ( S u c c e s s   N o t i f i c a t i o n�d  �c   � �b � �
�b 
titl � l 	 ��a�` � m   � � � � � & S u c c e s s f u l l y   L o g g e d�a  �`   � �_ � �
�_ 
desc � l 	 ��^�] � m   � � � � � X A l l   S a f a r i   t a b s   h a v e   b e e n   s e n t   t o t   O m n i F o c u s�^  �]   � �\ ��[
�\ 
appl � l 	 ��Z�Y � m   � � � � � > S a f a r i   T a b s   t o   O m n i F o c u s   S c r i p t�Z  �Y  �[  �h   � m   � � � ��                                                                                  GRRR  alis    H  Macintosh HD               �0ڲH+     O	Growl.app                                                      �����        ����  	                Applications    �1�      ���.       O  $Macintosh HD:Applications: Growl.app   	 G r o w l . a p p    M a c i n t o s h   H D  Applications/Growl.app  / ��  ��  ��   �  � � � l     �X�W�V�X  �W  �V   �  ��U � l     �T�S�R�T  �S  �R  �U       �Q � � � � � � � � � � � ��P�O�N�M�L�Q   � �K�J�I�H�G�F�E�D�C�B�A�@�?�>�=�<
�K .aevtoappnull  �   � ****�J 0 tabs_to_close  �I 0 
date_stamp  �H 0 	notetitle 	NoteTitle�G 0 safariwindow safariWindow�F 0 t  �E 0 tabtitle TabTitle�D 0 taburl TabURL�C 0 tabinfo TabInfo�B ,0 allnotificationslist allNotificationsList�A 40 enablednotificationslist enabledNotificationsList�@  �?  �>  �=  �<   � �; ��:�9 � ��8
�; .aevtoappnull  �   � **** � k    " � �   � �   � �   � �  & � �  ��7�7  �:  �9   � �6�6 0 j   � 8�5�4�3�2 #�1 ��0�/�. :�-�,�+�*�)�(�'�& w�%�$ ��#�"�!� ������ � � �� � ��� ���� ���� �� �� � ���5 0 tabs_to_close  
�4 .misccurdldt    ��� null
�3 
TEXT�2 0 
date_stamp  �1 0 	notetitle 	NoteTitle
�0 .miscactvnull��� ��� null
�/ 
cwin�. 0 safariwindow safariWindow
�- .ascrcmnt****      � ****
�, 
bTab
�+ .corecnte****       ****�* 0 t  
�) 
pnam�( 0 tabtitle TabTitle
�' 
pURL�& 0 taburl TabURL
�% 
ret �$ 0 tabinfo TabInfo
�# 
docu
�" 
kocl
�! 
FCit
�  
prdt
� 
FCno� 
� .corecrel****      � null
� .coreclosnull���    obj �  �  � ,0 allnotificationslist allNotificationsList� 40 enablednotificationslist enabledNotificationsList
� 
appl
� 
anot
� 
dnot
� 
iapp� 
� .registernull��� ��� null
� 
name
� 
titl
� 
desc
� .notifygrnull��� ��� null�8#jvE�O*j �&E�O��%E�O� �*j O*�k/E�O ��j O ���-j kih  ��-j j O��/E�O��,E` O�a ,E` Oa _ %_ %_ %_ %_ %E` Oa a k/  *a a a �_ a _ a a  UO�j [OY��OPW X   hUOa ! [a "a #lvE` $Oa %a &lvE` 'O*a (a )a *_ $a +_ 'a ,a -a . /O*a 0a 1a 2a 3a 4a 5a (a 6a . 7U � ���  �   � � � � F S a t u r d a y ,   M a r c h   1 6 ,   2 0 1 3   9 : 5 0 : 0 8   P M � � � � � U R L   L i s t   f r o m   S a f a r i   T a b s   o n   S a t u r d a y ,   M a r c h   1 6 ,   2 0 1 3   9 : 5 0 : 0 8   P M �  � �  ���
�	
� 
cwin�
N�
�	 kfrmID   �  � �  ��� �  ����
� 
cwin�N�
� kfrmID  
� 
bTab�  � � � � � H o w   d o   y o u   p r i n t   J S O N   f r o m   t h e   m o n g d b   r u b y   d r i v e r ?   -   S t a c k   O v e r f l o w � � � � � h t t p : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 3 3 8 1 3 5 8 / h o w - d o - y o u - p r i n t - j s o n - f r o m - t h e - m o n g d b - r u b y - d r i v e r � � � �D H o w   d o   y o u   p r i n t   J S O N   f r o m   t h e   m o n g d b   r u b y   d r i v e r ?   -   S t a c k   O v e r f l o w  h t t p : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 3 3 8 1 3 5 8 / h o w - d o - y o u - p r i n t - j s o n - f r o m - t h e - m o n g d b - r u b y - d r i v e r   � � �     � � � ��    � ��P  �O  �N  �M  �L   ascr  ��ޭ