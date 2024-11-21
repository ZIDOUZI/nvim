local arona = { -- 30x60 braille
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢏⢎]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⢿⣿⣿⣿⣟⣿⣿⡿⣿⡿⣿⣟⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠱⣑]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣞⣿⣿⣿⣯⣷⣿⣿⣟⣷⣿⣿⣿⣿⡿⣻⢯⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⢽⣿⣿⣿⣿⡟⡜⡼]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⢿⣿⣿⣿⣿⣿⣿⣿⣻⣾⣷⣟⣿⣿⣿⣿⣯⣷⣿⣿⣿⣿⣿⣿⣿⢿⣯⡿⣿⣿⣿⣿⣿⣝⢌⢎⣿⣿⣿⣿⣗⣝⣾]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣾⢯⣯⣿⣯⡿⣽⡽⣾⢮⡯⣯⣮⡻⣿⣿⣿⣿⣿⣿⣿⣿⢿⣟⣯⣷⣿⣿⣻⣷⡻⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⡳⣪⢞]],
  [[⣿⣿⣿⣿⣿⣿⣿⢟⢟⢿⣿⣿⣿⢿⣾⣿⢽⣯⣿⣿⣾⣿⡿⣿⣿⣿⣿⣿⣷⣿⣾⣾⣺⣺⣽⣽⣾⣗⡯⣿⡿⣟⣯⣿⣿⣻⣿⣮⡻⣿⣿⣿⣿⣿⣿⣿⣿⢝⣮⣿]],
  [[⣿⣿⣿⣿⣿⡟⡕⡕⡕⡹⢽⣿⠽⣫⣣⣇⢏⢿⣿⣽⣿⡯⣿⣿⣿⣽⣿⣷⣿⣟⣯⣿⡿⣿⣷⣿⣽⣻⣿⡮⣿⡿⣿⣽⣟⣿⣽⣷⣻⡺⣿⣿⣿⣿⣿⣿⣟⣾⣿⣿]],
  [[⣿⣿⣿⣿⢫⡲⡹⡪⡚⡌⡪⡨⢾⣿⣳⣿⠇⣽⣿⣯⣿⢽⣿⢿⣾⡿⣷⣿⣷⣿⢿⣻⣿⣟⣷⣿⣟⣿⣾⣽⡺⣿⣿⢾⣿⣟⣿⣻⣷⡻⡮⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣟⢸⣇⢗⢕⢑⢌⠢⠪⡸⣯⡿⡫⣱⣿⣿⣿⡽⣽⣿⣿⣯⣿⣿⣷⢿⣻⣿⣿⣯⣿⣯⣷⣿⣿⣟⣷⡯⣿⣟⣯⣿⣽⡿⣯⣿⣯⣻⡪⣿⣿⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣬⣊⠢⣢⠱⣔⢅⣷⡌⣦⣵⣾⡿⣿⣿⡯⡧⣿⣿⣿⣺⣿⣿⡿⣿⣿⣿⣿⣿⡷⣿⣯⣿⣯⣿⣻⣽⣺⡿⣗⣿⢷⣿⢿⣺⣿⢮⡻⡺⣿⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⡿⡌⣾⡼⢪⡯⢺⢟⢱⡾⣟⣷⣻⣿⢷⢯⣺⣿⣿⣟⢾⣿⣿⡿⣿⣿⣿⣿⣿⣟⣿⣗⣿⣯⣿⣯⣿⣺⡿⣟⣾⣟⣿⣻⣗⣿⣻⢮⢯⣻⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣟⡷⣴⢵⢽⣻⣶⡾⡽⣿⣻⣟⣾⣿⣫⣿⢮⣿⣽⡯⣻⣿⢿⣻⣿⣟⣿⣽⣯⣷⣻⣗⢿⡷⣿⢾⣻⡮⣿⣟⢾⣯⣿⢽⡷⣽⣻⢎⣗⣕⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⡾⣟⣗⣿⣳⡿⣯⡻⡿⣝⣮⡷⣵⣯⣿⢵⡿⣾⣻⢺⣟⣿⣻⡾⣯⣿⢾⣻⡾⣽⢮⣻⣟⣿⣻⣯⢯⡿⣽⢽⡷⣿⢽⣻⢮⣟⡧⡳⣕⢿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⡷⣽⣟⡾⣽⣞⣿⡷⡽⡿⣽⢯⣿⣿⣿⢿⡳⣿⣻⣳⢹⣯⣿⣳⣿⣻⣞⣿⢽⢯⡯⣇⢿⣞⣯⡿⣾⡳⣟⡯⣟⣿⡽⡽⣽⡳⣽⡺⡮⢮⢻⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⡯⣿⣺⣟⣿⣺⡷⡯⣫⢿⣽⣿⢿⢿⣾⣿⡯⣿⣽⣗⢝⣷⢿⣺⢷⣻⣽⢾⡿⣽⢝⢮⢺⣯⡷⣟⣿⡪⣿⢯⣟⣷⣻⢺⡯⣗⢽⢎⣯⣫⢺⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⢽⡯⣿⣗⣿⣞⣟⡟⢈⢈⣁⡉⠙⠛⠾⣽⣿⢵⢿⣾⢸⢽⣟⡞⣯⣟⣾⣻⣝⡯⣫⡳⣹⣷⣻⣯⢷⢹⣽⡳⣟⣾⡳⣽⣻⡳⡽⣱⢿⡜⣕⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⢽⢯⣿⡗⣟⢮⣳⣯⡣⣻⣿⣷⢆⠂⡂⢮⣿⣝⣿⣺⢽⢽⡵⡭⣪⣎⣗⢝⢞⢕⢿⢼⢺⣞⣷⣻⡝⣼⢷⢽⡻⣞⡯⣷⣻⣝⢮⣺⣻⡝⣜⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⡽⣽⣿⡯⣯⣟⣞⢾⡪⣻⣿⣿⣦⡑⡴⣽⣿⣷⡻⣾⢽⣗⣿⣝⢮⣗⡿⣝⣜⡮⣎⣤⢽⣺⣗⣟⢎⣾⢽⢯⣫⢿⣝⣷⣻⡎⡧⡻⣾⢝⢼⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣯⢾⣿⣫⢗⡷⡯⣏⡎⡿⣾⣟⣿⣻⣿⣿⣻⣿⣯⡻⣝⣿⡺⣮⡳⣳⢽⣺⣺⢽⣪⢿⢝⣞⡷⣳⣱⢯⣫⡺⣞⣿⣺⣞⣾⡣⡯⡪⡿⣱⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⣞⣗⢯⢯⢯⣟⡷⣝⢺⣻⣞⣯⣿⣷⣷⣿⣿⢿⣿⣿⣻⣿⣾⣾⣮⣟⣞⡾⣝⣾⢏⢿⡺⣝⢮⢪⣺⣲⣻⢽⣺⣺⣞⡾⣕⢝⢮⢺⣿⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⣟⢾⢍⣷⣻⣺⡽⣽⡚⣾⡽⣷⡿⣾⣿⣾⡿⡿⣟⢟⢿⣯⣷⣿⢾⡯⣟⡿⣝⡵⣯⣻⡺⣪⢮⣳⣳⣗⣯⢻⡺⣺⣺⡽⣪⢳⢹⢜⢾⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⡳⣏⡧⣿⣺⣺⢽⣳⢝⢮⡹⢿⣻⣿⣾⣮⣺⣮⣾⣽⣿⢿⣽⣾⣯⢿⣽⡪⣗⡟⣮⢮⡾⣮⣯⣞⢗⡏⡮⣺⡹⡽⡮⡯⡪⣇⢗⢝⢬⢿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⡺⡧⣻⣺⣷⢽⣻⣺⢽⢕⢽⣗⣭⡻⢯⣿⣿⣟⣿⣽⣾⣿⡿⣾⣯⡟⡵⡳⣱⡹⡳⠯⡯⢗⠷⢟⢇⢻⢽⡿⣜⡟⡼⡱⡝⡮⡢⡫⡎⣯⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⣿⣽⣽⣞⣿⣇⢿⣺⡽⣺⢸⣿⢾⡿⣗⣧⣛⠿⡿⡿⢿⠻⣫⢫⢪⢪⡝⣾⢿⡽⡪⣱⣼⡶⣷⣵⣈⠎⣿⢏⢾⡸⡪⡳⣹⣝⢼⢸⣺⣳⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⣿⣿⣿⣯⢿⣯⡷⣷⣽⣽⣕⣝⣳⣝⡿⡷⡽⣯⡳⣿⣝⢧⢳⢱⢱⡺⣞⣽⡟⣜⣾⣿⣯⣿⡿⣯⣿⣆⢱⣽⣳⢱⢹⢜⣞⣮⣯⣾⣿⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⢿⣽⣷⡳⣽⡿⣿⢽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣷⣯⣯⡷⡨⣇⣿⣗⣿⠣⣾⣿⣷⣿⣟⣿⣿⢿⣷⠸⡞⡕⣕⣕⣽⣾⣿⣻⣽⣿⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⢿⡽⡾⣹⡱⡻⣽⣟⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡫⣢⣳⡯⣷⣻⢱⣿⣿⣽⣾⣿⣿⣽⣿⣿⢌⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⢯⣳⢿⡷⡿⣾⢾⡾⣿⣺⣿⣿⣿⣿⣿⣿⣿⢿⣻⣿⣿⣿⡳⡽⣧⣿⣿⡜⡎⢼⣿⣯⣿⣿⣻⣾⡿⣾⣻⢵⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿]],
  [[⣿⣿⣿⣿⣷⣝⢕⣍⢯⣻⣟⣿⣟⣷⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣌⢳⣽⣿⣾⣿⡌⢾⣿⣻⣯⣿⣿⣽⢿⣻⣿⢹⣗⣿⣿⣿⣿⣿⣿⣟⣿⣿⣟⣯⣿⣿⣿⣿]],
  [[⣿⣿⣿⣿⣿⣿⣻⣾⢮⢷⣿⣯⣿⡿⡞⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣽⣟⣧⡛⣯⣿⣿⡪⣻⣿⢿⣟⣿⣾⣻⣿⣻⣽⣨⣪⢺⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿]]
}

local toki = { --30x60 braille
  [[⣿⡟⢐⠨⢐⠁⣾⡿⡋⠔⡈⡂⣑⣴⣵⣿⢿⢿⢟⡿⡿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣆⠀⠀⠘⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠡⡙⡝⡜⡜⡜⡜⡜⢜]],
  [[⡿⠐⡀⢂⠂⣼⡿⢁⠂⠡⠐⣴⣿⢿⢝⢮⣯⣾⣗⣷⣽⣪⡻⡄⠀⠀⠐⠀⠐⠀⠀⠂⢹⣿⡂⠈⠀⠸⣿⣿⣿⣤⡈⠀⠀⠀⠀⠀⠁⠀⡁⠁⠢⡘⡜⡜⡜⢜⠜⡌]],
  [[⣧⣐⣀⣿⣿⣿⢁⠂⢈⢀⣾⣿⡿⣹⣺⣿⣿⣿⣿⠟⢏⢍⢬⢨⢀⠈⠀⢀⠀⡀⠠⠀⡐⢄⢃⢀⠀⠈⣿⣿⣿⢿⢟⡦⣂⠀⠐⠀⠀⠀⠀⠀⢁⠢⢘⢌⢎⠪⡨⢌]],
  [[⠿⠿⣿⣿⣿⡗⢀⠐⠀⣸⣿⣿⣝⢮⣿⡿⢟⢩⠢⡋⢅⡑⡄⡕⡐⡅⣓⣒⢲⠰⡤⣀⡪⡑⡪⠢⡱⡠⡙⢽⡪⣫⢣⡣⡣⡳⡄⡂⠀⠁⠀⠂⠐⠈⢔⠨⠢⡑⢌⠢]],
  [[⠀⠄⠀⢸⣿⡇⠀⠄⠂⣿⣿⣟⡗⢣⢑⠌⠊⠀⢂⠜⠜⠘⠜⠜⡜⣜⢖⡜⡬⣓⢵⢱⢍⡒⠮⡌⡆⣎⢘⢔⢘⠜⡕⡕⡝⡜⡜⡜⢔⠠⠀⠠⠀⠀⢂⠪⢨⢈⠢⠡]],
  [[⠀⠠⠈⢘⣿⡇⠀⡀⠀⢺⡿⢋⠔⡡⢢⠢⢆⢅⢆⢆⢇⢏⢮⢪⡲⡬⣑⡻⣞⣎⢧⡳⡵⡹⣕⢮⢪⡪⡪⣒⢌⡂⡊⢪⢪⢪⠪⡊⡪⡊⡪⢠⠀⠠⠀⠅⡂⡂⠅⠡]],
  [[⠈⠀⠄⠀⠿⣯⠀⠀⠀⢘⠅⢅⠪⡸⠈⡔⡪⡪⡪⣪⢣⡫⡪⡳⡵⣝⣮⣻⢶⣭⡳⡝⡮⡫⡮⡪⣇⢗⡝⣜⢔⢕⢕⠤⡑⢅⠣⡊⡢⡂⠪⡐⠡⠑⠄⡂⠂⠄⠡⠈]],
  [[⠀⠀⢀⠠⠀⠈⠁⡀⠐⢐⢸⠠⡱⡁⡎⡎⢎⢮⢺⡸⣕⢽⡱⣝⡺⣺⣽⣻⢿⣾⣽⣳⢧⠫⢎⢯⡪⣇⢯⢪⢎⢖⣅⡋⢎⠢⢌⠂⡢⠨⢂⠌⠌⠌⢐⠀⠅⡈⠄⠁]],
  [[⠀⠀⠀⠀⠀⠀⠄⡀⠁⣜⢢⢱⢱⢸⢜⡎⢜⣕⢗⣝⢮⡳⣽⣺⢿⣮⡻⣽⣷⢷⡯⡿⣗⢽⢌⠕⢧⢳⢕⡝⡎⡗⣆⡓⢦⡉⡢⠱⡀⢑⠐⠈⠄⠡⠀⢂⠐⠀⠄⠁]],
  [[⠀⠀⠁⡀⠈⠀⠠⠀⠠⡇⡕⣕⡇⣗⣕⢧⢱⢪⡳⣕⣷⣽⣞⡿⣯⡷⣿⣎⢿⣟⣿⣟⢮⡳⣝⢝⢦⡙⢜⡎⣇⢳⢱⢱⡁⠳⡌⡆⠌⡂⠨⠠⠑⡀⠁⠄⢀⠁⢐⠀]],
  [[⣶⣮⣦⣦⣴⣈⠀⠀⢮⡣⡳⣹⢕⣷⣳⡿⣎⢮⡺⣷⣻⣾⣯⡿⣟⣿⣽⣻⣷⡹⣯⡯⣳⢹⢪⡳⡱⡝⣆⠹⡜⣆⠹⣸⢸⠠⡑⡕⡕⡈⢐⠀⠡⠀⢁⠐⠠⠈⠀⡀]],
  [[⣿⣿⣿⣿⢿⢃⢟⠄⡗⣕⢝⢼⠱⣿⣳⡿⣿⡪⣎⢟⢾⣻⡾⣿⣻⡿⣾⣗⣿⡻⡜⣕⢗⢽⡸⡪⡳⡱⡱⡣⡑⡕⡕⠸⡸⡱⡐⠨⡊⢜⢄⠌⠀⢁⠀⠐⡀⠄⠁⡀]],
  [[⡿⡟⡏⣎⢧⢱⢱⠠⡫⡪⡎⣏⢇⢿⣳⣻⣟⣯⡻⣷⣕⡝⣟⢿⣽⣟⣯⢟⢾⢝⢽⢨⠳⢱⢩⡪⡪⡪⠲⡌⡢⡑⡝⠄⢹⢸⠨⠠⢱⢈⢎⢦⢀⠀⠀⢁⠠⠐⠀⠄]],
  [[⢕⢕⢝⢜⢜⢸⢸⠨⡺⡸⡪⡎⡇⣝⢽⢮⡻⣯⡿⡝⡯⡿⡶⡵⣸⡸⡨⣕⢕⢵⠱⡣⡎⡌⢜⠸⢑⠙⠂⠀⠑⠀⢉⠡⡐⠕⢅⠍⢆⢕⢌⠪⡲⡄⠂⠀⡐⢈⠀⠂]],
  [[⢕⢕⢕⢕⠅⡇⡣⠨⡪⡺⡜⡎⣗⠜⡮⡺⡜⡮⣪⢻⡘⣝⢮⢳⢕⢽⡱⣳⢹⢕⢗⡌⠺⡸⡢⠑⠀⠀⡄⡉⢯⠆⡐⡑⡀⢱⢐⢑⠕⡌⡪⢕⠜⢜⢆⠄⠂⠄⠂⡁]],
  [[⡱⡱⢱⠱⡑⢌⠪⠨⡪⡺⡸⡪⡪⡇⢝⢎⢧⡫⡎⡧⡫⡆⢫⢎⢏⠺⣜⢮⡣⡫⢇⢏⢎⠲⠄⣴⡠⠣⡸⡠⣸⢵⣻⡐⡀⢸⠀⡕⡑⠌⡎⡘⢜⢆⠕⡕⡌⡀⠡⠀]],
  [[⢌⠪⡂⡣⡑⢅⠅⠅⡇⡏⡎⡞⡜⡎⡎⡇⡗⡕⣝⢜⢕⢝⢔⠨⡓⡳⣈⠊⠎⢇⢧⠨⡨⣨⣺⢽⣻⣺⣞⢿⢽⢝⣞⢦⢂⠹⠀⢕⢕⡑⠜⡌⡂⠣⣓⢌⠪⣢⠐⠀]],
  [[⠨⠪⠨⡂⡊⡢⠡⠨⢸⢸⢌⢮⢪⡪⡲⡘⡕⣝⢌⢪⢢⡑⠕⠳⠤⠡⡃⠳⠑⡔⣔⣬⢮⣟⣾⣻⣺⡺⡮⡯⣫⢷⢽⢵⢅⠅⠡⠨⡢⡣⡑⢕⢌⢌⢂⠇⡗⡌⡳⣀]],
  [[⢈⠪⡈⡂⠢⡈⡂⠌⡂⡇⡳⡘⡜⡜⡜⡆⡘⡜⣔⢢⢥⣣⠁⠅⠀⠄⡐⢦⣿⣺⢯⡯⣿⣺⣳⣳⣳⢯⢯⢯⢯⣗⡯⣟⡆⡣⠈⢄⢣⢣⢣⢃⢇⠢⡢⡑⠌⢎⢖⢜]],
  [[⠀⡂⡂⠌⢂⠂⡂⠨⢐⠸⡸⡸⡨⢪⡘⢜⢔⡈⠪⡂⠅⠀⣠⠀⡊⢢⢱⣰⣟⢾⢽⣽⣻⣻⡽⣾⢽⢯⣟⣯⢿⣺⡽⣯⠃⢸⠀⢒⠌⡎⢎⢎⢪⢊⢆⠊⢥⠑⠌⢎]],
  [[⠀⢐⠠⢁⠐⡀⠂⡈⢐⠨⠸⡸⣘⢆⡓⣄⠃⢇⢌⠨⠀⡀⠱⠷⢥⢴⢯⢷⢽⢽⢽⣺⣳⢯⢿⢽⢯⣟⡷⣯⣟⣷⣻⠇⡈⠨⡎⡀⢇⢕⢕⢕⢕⢕⢌⢪⠠⠙⡌⡢]],
  [[⠀⠀⡂⠐⡀⠄⠂⠀⠄⢈⠢⠑⡕⢕⢕⢌⠪⡢⡡⠐⢄⠈⡫⣗⢯⢯⢯⣫⢾⢽⢽⣺⡽⣯⣟⣿⣹⣗⣟⣷⣻⣺⠝⠠⠐⡀⢳⢀⠱⡨⡪⡪⡪⡪⡂⡇⠅⠅⠌⡪]],
  [[⠀⠀⡂⠁⡀⠄⠈⠄⠈⠀⠈⡐⠌⡱⡑⢕⢕⢆⠌⢑⠀⢂⠐⠌⠙⢞⡷⡽⡽⡽⡯⣷⣻⣳⣗⣟⣞⣷⣻⣞⡷⠏⠨⡈⡂⢔⢘⠆⡈⡒⡜⡜⡜⡜⡔⢕⠡⢁⠂⢂]],
  [[⠀⠄⠀⠂⠠⠐⠀⠀⠐⠀⠁⠀⠂⠐⢈⠂⠅⢑⢍⠂⠌⠄⡙⡚⠂⠀⢈⠛⠯⡿⡽⠷⠋⠁⢙⣞⣷⣳⢷⠷⢋⠨⡈⠢⡸⡨⡂⡇⢄⢘⢌⢎⢎⢪⢪⠪⢐⠐⡜⡰]],
  [[⠀⠄⠁⠠⠀⠠⠀⠁⠀⠂⠈⠀⠂⢁⠀⠨⠀⠐⠄⡑⡀⠅⡐⡐⡈⠠⠠⠨⠠⡑⢘⠈⠄⢈⠉⠨⠠⡐⡀⡢⢐⠌⡢⠣⡣⡪⡪⡘⢔⠢⡑⡕⢕⠕⢕⢅⢣⢑⢰⡿]],
  [[⠀⠀⡀⠄⠀⠄⠀⡈⠀⠄⠁⡀⠁⠠⠐⠈⠄⢁⠡⢂⢂⠐⠠⢐⠐⡀⢂⠨⠐⡐⠐⡈⠄⠂⢨⢀⢑⢐⠐⢌⠢⠨⢸⢘⢌⢎⠪⠨⢀⠁⢢⠱⡑⣍⠪⠢⡑⠄⡯⣿]],
  [[⠀⠀⡀⠀⠄⠠⠀⠠⠀⠐⠀⡀⢈⠀⠂⡀⠅⠀⠨⢐⢐⠀⠡⠀⠅⡐⠀⡂⠅⢂⠁⡐⢀⠁⢕⢅⢕⢔⠑⠄⢅⠣⣂⠁⢃⠂⠌⠨⠀⠌⢐⢅⢣⣂⠣⡑⠨⣸⢽⣽]],
  [[⠀⢀⠠⠀⠠⠀⠐⠀⡀⠁⠄⠀⠄⠀⢁⠀⢈⠀⠐⢐⢐⠈⠄⠂⠐⡀⠡⠀⠅⢐⠠⠐⠠⠈⠎⠆⠇⠕⠨⠊⠊⢀⠑⡈⠄⠀⢂⠡⠡⠈⡀⢕⢐⢘⢲⡨⢂⠯⣟⣾]],
  [[⠀⠀⡀⠄⠀⠂⠈⢀⠠⠐⠀⠂⠀⢀⠀⠄⠠⠀⢈⠐⡐⠨⠀⠂⠁⡐⡈⠄⡑⡐⠈⡀⠅⠌⠄⠡⠈⠂⠂⡐⠈⠄⠄⠠⠀⠅⠂⠄⠅⢅⠀⢌⠢⡑⡐⢭⠲⣅⢌⠺]],
  [[⠀⠠⠀⠀⠂⠁⠐⠀⠀⠀⢀⠠⠈⠀⠀⠄⠀⡁⢀⠠⢈⠂⠅⠂⠀⠄⢂⢂⡢⢅⠀⠂⡂⠠⠐⢀⠂⡁⢂⠀⡁⠌⠀⠁⠁⠌⠈⠄⡁⡑⡔⢕⢐⠌⢌⠢⡙⢖⢭⢺]]
}

local headers = { arona, toki }

local function footer()
  local stats = require("lazy").stats()
  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  return "   Have Fun with neovim"
      .. "  󰀨 v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "  󰂖 "
      .. stats.count
      .. " plugins in "
      .. ms
      .. "ms"
end

return {
  'goolord/alpha-nvim',
  cond = false,
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local db = require('alpha.themes.dashboard')
    local sc = db.section
    local b = db.button

    sc.leader = 'space'

    sc.header.val = headers[math.random(#headers)]
    sc.header.opts.hl = "AlphaHeader"

    sc.buttons.val = {
      -- TODO: currently disable buttons, until alpha support vertical padding
      -- b("e",            "  New file",          "<CMD>ene <CR>"),
      -- b("space e",      "󰙅  File Tree",         "<CMD>NvimTreeToggle<CR>"),
      -- b("space f d",    "󰈞  Search File",       "<CMD>Telescope fd<CR>"),
      -- b("space f r",    "󱋢  Recent files",      "<CMD>Telescope frecency<CR>"),
      -- b("space f t",    "  Find text",         "<CMD>Telescope live_grep<CR>"),
      -- b("space c",      "  Config",            "<CMD>lua require('lazyvim.util').telescope.config_files()() <CR>"),
      -- b("space s",      "󰖲  Restore Session",  [[<CMD>lua require("persistence").load() <cr>]]),
      -- b("space f n",    "󰂜  View Notification",[[<CMD>Noice telescope <cr>]]),
      -- b("space x",      "  Lazy Extras",       "<CMD>LazyExtras <cr>"),
      -- b("space l z",    "󰒲  Lazy",              "<CMD>Lazy <cr>"),
    }

    sc.footer.opts.hl = "AlphaFooter"

    local alpha_action = vim.api.nvim_create_augroup('AlphaAction', { clear = true })

    -- wait for Lazy loaded, and Lazy.stats() is available
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      group = alpha_action,
      callback = function()
        db.section.footer.val = footer()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BDeletePre *',
      group = alpha_action,
      callback = function ()
        local bufnr = vim.api.nvim_get_current_buf()
        local name = vim.api.nvim_buf_get_name(bufnr)

       if name == "" then
          vim.cmd [[:Alpha | bd#]]
        end
      end,
    })

    vim.keymap.set('n', "<leader>a", "<CMD>Alpha<CR>")
    local alpha = require('alpha')
    alpha.setup(db.config)
    -- FIX: in alpha.lua L786, alpha pass true to function `start`, which cause alpha won't open
    -- when nvim have passed any argument. this is what we don't want. we re-resigter this autocmd.
    local group_id = vim.api.nvim_create_augroup('alpha_start', { clear = true })
    vim.api.nvim_create_autocmd('UIEnter', {
      group = group_id,
      pattern = "*",
      nested = true,
      callback = function ()
        local args = vim.fn.argv()
        ---@cast args table
        local hasdir = #args == 0
        for i = 1, #args do
          local path = vim.fn.expand(args[i])
          if not hasdir and vim.fn.isdirectory(path) == 1 then
            vim.fn.chdir(path)
            hasdir = true
          end
        end
        if hasdir then
          alpha.start(false, db.config)
          -- TODO: alpha show before empty buffer loaded.
          -- for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          --   local ft = vim.api.nvim_buf_call(bufnr, function() return vim.bo.filetype end)
          --   vim.print { "detected filetype: ", ft }
          --   if vim.api.nvim_buf_get_name(bufnr) == '' and ft ~= 'alpha' then
          --     vim.api.nvim_buf_delete(bufnr, {})
          --   end
          -- end
        end
      end
    })
  end
}
