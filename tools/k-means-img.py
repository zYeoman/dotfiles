'''
Authors: Robert Layton <robertlayton@gmail.com>
         Olivier Grisel <olivier.grisel@ensta.org>
         Mathieu Blondel <mathieu@mblondel.org>
         Yongwen Zhuang <yeo@mickir.me>

License: BSD 3 clause
'''

print(__doc__)
import cv2
import numpy as np
from sklearn.cluster import KMeans
from sklearn.metrics import pairwise_distances_argmin
from sklearn.utils import shuffle
from sklearn.datasets import load_sample_image
from time import time

n_colors = 64
n_rows = 8

china = load_sample_image("china.jpg")
# china = cv2.imread("t.png")

# Convert to floats instead of the default 8 bits integer coding. Dividing by
# 255 is important so that plt.imshow behaves works well on float data (need to
# be in the range [0-1])
china = np.array(china, dtype=np.float64) / 255

# Load Image and transform to a 2D numpy array.
w, h, d = original_shape = tuple(china.shape)
assert d == 3
image_array = np.reshape(china, (w * h, d))

print("Fitting model on a small sub-sample of the data")
t0 = time()
image_array_sample = shuffle(image_array, random_state=0)[:1000]
kmeans = KMeans(n_clusters=n_colors, random_state=0).fit(image_array_sample)
print("done in %0.3fs." % (time() - t0))

# Get labels for all points
print("Predicting color indices on the full image (k-means)")
t0 = time()
labels = kmeans.predict(image_array)
print("done in %0.3fs." % (time() - t0))


codebook_random = shuffle(image_array, random_state=0)[:n_colors + 1]
print("Predicting color indices on the full image (random)")
t0 = time()
labels_random = pairwise_distances_argmin(codebook_random,
                                          image_array,
                                          axis=0)
print("done in %0.3fs." % (time() - t0))


colors = kmeans.cluster_centers_*256
colors = colors.astype(np.uint8)

colors_show = np.zeros((20*n_rows, 120*n_colors/n_rows, 3))

for i in range(n_rows):
    for j in range(round(n_colors/n_rows)):
        colors_show[i*20:(i+1)*20,j*120:(j+1)*120,:] = np.ones((20,120,3))*colors[i+j*n_rows,:]

cv2.imshow('colors', colors_show.astype(np.uint8))
cv2.waitKey(0)
