if !exists('loaded_snippet') || &cp
  finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet control <control id=\"".st.et."\" visuals=\"".st.et."\" dataSource=\"".st.et."\" />".st.et
exec "Snippet form <form id=\"".st.et."\" visuals=\"".st.et."\" focusStyle=\"".st.et."\" navStyle=\"".st.et."\" dataSource=\"".st.et."\" shortcutNavigation=\"".st.et."\"><CR>  <list id=\"".st.et."\" visuals=\"".st.et."\" itemVisuals=\"".st.et."\" itemSource=\"".st.et."\" shortcutSelect=\"".st.et."\" /><CR>  <list id=\"".st.et."\" visuals=\"".st.et."\" itemVisuals=\"".st.et."\" itemSource=\"".st.et."\" shortcutSelect=\"".st.et."\" /><CR>  <!-- More Lists or Menus --><CR></form>".st.et
exec "Snippet frame <frame id=\"".st.et."\" menuBar=\"".st.et."\" visuals=\"".st.et."\" transition=\"".st.et."\"><CR><CR></frame>".st.et
exec "Snippet xi:include <xi:include xlink:href=\"".st.et."\" />".st.et
exec "Snippet list <list id=\"".st.et."\" visuals=\"".st.et."\" itemVisuals=\"".st.et."\" itemSource=\"".st.et."\" focusedCursor=\"".st.et."\" shortcutSelect=\"".st.et."\" />".st.et
exec "Snippet menu <menu id=\"".st.et."\" itemSource=\"".st.et."\" visuals=\"".st.et."\" menuVisuals=\"".st.et."\" itemVisuals=\"".st.et."\" transition=\"".st.et."\" shortcutSelect=\"".st.et."\" shortcutBack=\"".st.et."\" />".st.et
exec "Snippet menuBar <menuBar id=\"".st.et."\" visuals=\"".st.et."\" itemVisuals=\"".st.et."\" menuVisuals=\"".st.et."\" transition=\"".st.et."\" shortcuts=\"".st.et."\" shortcutSelect=\"".st.et."\" shortcutBack=\"".st.et."\" shortcutNavigation=\"".st.et."\" />".st.et
exec "Snippet model <model id=\"".st.et."\" src=\"".st.et."\" />".st.et
exec "Snippet page <page id=\"".st.et."\" menuBarItemSource=\"".st.et."\" visuals=\"".st.et."\" dataSource=\"".st.et."\"><CR><CR></page>".st.et
exec "Snippet dataService <dataService id=\"".st.et."\" class=\"".st.et."\" />".st.et
exec "Snippet onCommand <onCommand name=\"".st.et."\" handler=\"".st.et."\" /><onCommand name=\"".st.et."\" handler=\"".st.et."\" />".st.et
exec "Snippet onCommand <onCommand name=\"".st.et."\" handler=\"".st.et."\" />".st.et
exec "Snippet onKey <onKey keyCode=\"".st.et."\" handler=\"".st.et."\" />".st.et
exec "Snippet onKey <onKey keyCode=\"".st.et."\" cmd=\"".st.et."\" />".st.et
exec "Snippet tabFrame <tabFrame id=\"".st.et."\" visuals=\"".st.et."\" tabVisuals=\"".st.et."\" transition=\"".st.et."\"><CR>	<page id=\"".st.et."\" tabFrame.icon=\"".st.et."\" visuals=\"".st.et."\"><CR>		<control id=\"".st.et."\" dataSource=\"".st.et."\" visuals=\"".st.et."\" /><CR>	</page><CR>	<page id=\"".st.et."\" tabFrame.icon=\"".st.et."\" visuals=\"".st.et."\"><CR>		<control id=\"".st.et."\" dataSource=\"".st.et."\" visuals=\"".st.et."\" /><CR>	</page><CR>	<!-- More Pages --><CR></tabFrame>".st.et
exec "Snippet textField <textField id=\"".st.et."\" prompt=\"".st.et."\" visuals=\"".st.et."\" type=\"".st.et."\" maxChars=\"".st.et."\" text=\"".st.et."\" />".st.et
exec "Snippet action <action on=\"".st.et."\"><CR>  <animate targetNode=\"".st.et."\" targetAttr=\"".st.et."\" from=\"".st.et."\" to=\"".st.et."\" dur=\"".st.et."\" ease=\"".st.et."\" /><CR></action>".st.et
exec "Snippet animateColor <animateColor on=\"".st.et."\" targetNode=\"".st.et."\" targetAttr=\"".st.et."\" from=\"".st.et."\" to=\"".st.et."\" dur=\"".st.et."\" ease=\"".st.et."\" />".st.et
exec "Snippet animate <animate on=\"".st.et."\" targetNode=\"".st.et."\" targetAttr=\"".st.et."\" from=\"".st.et."\" to=\"".st.et."\" dur=\"".st.et."\" ease=\"".st.et."\" />".st.et
exec "Snippet fx:kerneleffect <fx:kerneleffect type=\"".st.et."\" id=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" rx=\"".st.et."\" ry=\"".st.et."\" opacity=\"".st.et."\" rendering=\"".st.et."\" />".st.et
exec "Snippet border <border x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" opacity=\"".st.et."\" src=\"".st.et."\" dims=\"".st.et."\" />".st.et
exec "Snippet canvas <canvas id=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\"><CR><CR></canvas><image src=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" />".st.et
exec "Snippet fx:pixeleffect <fx:pixeleffect type=\"".st.et."\" id=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" opacity=\"".st.et."\" rendering=\"".st.et."\" color=\"".st.et."\" luminance=\"".st.et."\" chrominance=\"".st.et."\" />".st.et
exec "Snippet container <container id=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\"><CR><CR></container>".st.et
exec "Snippet fx:pixeleffect <fx:pixeleffect type=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" opacity=\"".st.et."\" />".st.et
exec "Snippet dockLayout <dockLayout x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\"><CR><CR></dockLayout>".st.et
exec "Snippet gridLayout <gridLayout x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" columns=\"".st.et."\"><CR><CR></gridLayout>".st.et
exec "Snippet image <image id=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" opacity=\"".st.et."\" src=\"".st.et."\" />".st.et
exec "Snippet xi:include <xi:include href=\"".st.et."\" parse=\"".st.et."\"><CR>  <fallback><CR>    <!-- PUT THE ERROR MESSAGE TEXT HERE --><CR>  </fallback><CR></xi:include>".st.et
exec "Snippet defs <defs id=\"".st.et."\"><CR>  <dockLayout clip=\"".st.et."\"><CR>    <rect x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" fill=\"".st.et."\" /><CR>  </dockLayout><CR></defs><listView id=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" depth=\"".st.et."\" navStyle=\"".st.et."\" columns=\"".st.et."\" hWrap=\"".st.et."\" vWrap=\"".st.et."\" scrollTime=\"".st.et."\" clip=\"".st.et."\" hl=\"".st.et."\" />".st.et
exec "Snippet scrollBar <scrollBar id=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" layout=\"".st.et."\"><CR>  <rect fill=\"".st.et."\" opacity=\"".st.et."\" /><CR></scrollBar><defs id=\"".st.et."\"><CR>  <dockLayout clip=\"".st.et."\"><CR>    <rect x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" fill=\"".st.et."\" /><CR>  </dockLayout><CR></defs><listView id=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" depth=\"".st.et."\" navStyle=\"".st.et."\" columns=\"".st.et."\" hWrap=\"".st.et."\" vWrap=\"".st.et."\" vScrollBar=\"".st.et."\" scrollBarIsView=\"".st.et."\" focusBounds=\"".st.et."\" scrollTime=\"".st.et."\" clip=\"".st.et."\" hl=\"".st.et."\" />".st.et
exec "Snippet defs <defs id=\"".st.et."\"><CR>  <rect fill=\"".st.et."\" /><CR></defs><listView id=\"".st.et."\" hl=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" />".st.et
exec "Snippet fx:particles <fx:particles id=\"".st.et."\" maxparticles=\"".st.et."\" xlink:href=\"".st.et."\" dynamicFrameRate=\"".st.et."\"><CR><CR>  <fx:emitter x0=\"".st.et."\" y0=\"".st.et."\" x1=\"".st.et."\" y1=\"".st.et."\" shape=\"".st.et."\" particlewidth=\"".st.et."\" particleheight=\"".st.et."\" intensity=\"".st.et."\" lifespan=\"".st.et."\" lifespanspread=\"".st.et."\" fadeindur=\"".st.et."\" fadeoutdur=\"".st.et."\" /><CR><CR>  <fx:affecter type=\"".st.et."\" shape=\"".st.et."\" angle=\"".st.et."\" anglespread=\"".st.et."\" angleperiod=\"".st.et."\" intensity=\"".st.et."\" intensityspread=\"".st.et."\" intensityperiod=\"".st.et."\" randomness=\"".st.et."\" swirlsize=\"".st.et."\" /><CR><CR></fx:particles>".st.et
exec "Snippet rect <rect x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" fill=\"".st.et."\" />".st.et
exec "Snippet scrollLayout <scrollLayout id=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" scrollSpeed=\"".st.et."\" delay=\"".st.et."\" begin=\"".st.et."\"><CR><CR></scrollLayout>".st.et
exec "Snippet setString <setString on=\"".st.et."\" targetNode=\"".st.et."\" targetAttr=\"".st.et."\" to=\"".st.et."\" begin=\"".st.et."\" />".st.et
exec "Snippet stackLayout <stackLayout id=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" layout=\"".st.et."\"><CR><CR></stackLayout>".st.et
exec "Snippet text <text id=\"".st.et."\" x=\"".st.et."\" y=\"".st.et."\" width=\"".st.et."\" height=\"".st.et."\" font=\"".st.et."\" string=\"".st.et."\" color=\"".st.et."\" opacity=\"".st.et."\" ellipsize=\"".st.et."\" />".st.et
