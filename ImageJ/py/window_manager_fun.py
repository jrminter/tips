from ij import WindowManager

print(WindowManager.getImageTitles())

non_img_wins = 	WindowManager.getNonImageWindows()
print(len(non_img_wins))

img_cnt = 	WindowManager.getImageCount()
print(img_cnt)