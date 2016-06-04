
# ������3��  2016�N03��19��

############################################################
#                   ��11�� ���p���v���                    #
############################################################


  ## ----- SECTION 154 CRAN Task Views

# Task Views���Ǘ�����p�b�P�[�W�𓱓�


# install.packages("ctv")
# install.views("Econometrics")




  ## ----- SECTION 155  ��ʉ����`���f�������s����

# install.packages("faraway") # faraway�p�b�P�[�W�̃f�[�^���ɐ������܂�
library (faraway)
data (gala)
head (gala)

# �|�A�\����A���f��
# �P���ɃA���t�@�x�b�g���ɍŏ���2������ϐ��Ƃ���
model1 <- glm (Species ~ Adjacent + Area, data = gala, family = poisson)
summary (model1)





  ## ----- SECTION 156 ��ʉ����`���f�����X�V/��r����

# ����1�ϐ��𓊓�����
model2 <- update (model1, . ~ . + Elevation)
summary (model2)

# 2�̃��f�����r����
anova (model1, model2, test ="Chi")

## �����ϐ������ׂē����������f��
model3 <- glm (Species ~ . , data = gala, family = poisson)
summary (model3)

# 1���ϐ������炵�Ĉ�E�x�̕ω����݂�
drop1 (model3, test = "Chi")

# ���ׂĂ𓊓��������f�����玩���I�Ƀ��f���I������
library (MASS)

#  scope�����̎w�肪�Ȃ��ꍇ�A�f�t�H���g�ł�"backward"
stepAIC (model3)






  ## ----- SECTION 157 �񍀕��z�����肵�āA�f�[�^�Ɉ�ʉ����`���f����K�p����

# �����������G�ȓ񍀃��f���̗�
?esoph # �����H�����f�[�^
head (esoph)

# ���f�������ӂɁu�늳��(ncases)�v�Ɓu��늳��(ncontrols)�v
# �u�N��(agegp)�v�Ɓu����(alcgp)�v�A�u�i��(tobgp)�v�̌��ʂ��w��
binom2 <- glm (cbind (ncases, ncontrols) ~ agegp + tobgp * alcgp,
               data = esoph, family = binomial())

anova (binom2, test = "Chi")

# �����I�Ƀ��f���I��
binom2.step <- stepAIC (binom2)

#  �I�΂ꂽ���f����ANOVA�\
binom2.step$anova

#  �����̃��f���������̍�������
update (binom2, .~. - tobgp:alcgp)

binom3 <- glm (cbind (ncases, ncontrols) ~ 1,
               data = esoph, family = binomial())


binom3.step <- stepAIC (binom3, direction = "forward", 
                        scope =  list (upper =  ~ agegp * tobgp * alcgp))






  ## ----- SECTION 158 �听�����͂����s����

# ���O���e�T�̔ƍߗ�
USArrests

# ���֍s����w��
pc.cr <- princomp (USArrests, cor = TRUE)

# �����͂̂����ʂ̎听��
summary (pc.cr, loadings = TRUE)

# �听�����_
pc.cr$scores [1:5, ]
# �听�����חʂƎ听�����_�𓯎��Ƀv���b�g
biplot (pc.cr)





  ## ----- SECTION 159 ���q���͂����s����

# �wR��S-PLUS�ɂ�鑽�ϗʉ�́x�� 4 ��
# 1960 �N��̐���ʕ��ϗ]���f�[�^�i�C���Łj
life <- read.table ("life.txt", row.names = 1)
head (life)

#�ufactanal�v�֐���3���q�܂ŋ��߂�
life.fa <- factanal(life, factors = 3, scores = "regression")
# ���ʂ��m�F����
life.fa

# ���q���חʂ��m�F
life.fa$loadings
# loadings (life.fa)
# ���q���_���m�F
life.fa$scores

# ���q���_�ƈ��q���חʂ̃o�C�v���b�g
biplot (life.fa$scores, life.fa$loadings)

# �Ό���]
life.fa2 <- factanal (life, factors = 3,
                       scores = "regression", rotation = "promax")

# ���ʂ��m�F����
life.fa2
biplot (life.fa2$scores, life.fa2$loadings)



# ������]�̌��ʂ��瓱�o���邱�Ƃ��\
life.fa3 <- promax (loadings (life.fa), m = 4)
life.fa3

#�uGPArotation�v�p�b�P�[�W�𓱓�
# install.packages ("GPArotation")
library (GPArotation) # ���̃��C�u�����𓱓������
life.fa3.ob <- factanal (life, factors = 3,
                         rotation = "oblimin", # �I�u���~���@���w��ł���
                         scores = "regression")

biplot (life.fa3.ob$scores, life.fa3.ob$loadings)





  ## ----- SECTION 160  �Ή����͂����s����

library (MASS) #�uMASS�v�p�b�P�[�W�����[�h
# ���ƊႻ�ꂼ��̐F�̑Ή��f�[�^
caith

(caith.ca <- corresp (caith, nf = 2))

# �o�C�v���b�g��`��
biplot (caith.ca)
# �s�͔_��Ŋe��͖q���n�ɂ��Ă̕����̏�����\�킷�f�[�^
head (farms)

library (MASS)
(farms.mca <- mca (farms, abbrev=TRUE))

plot (farms.mca)





  ## ----- SECTION 161 �N���X�^�[���͂����s����
# �wR��S-PLUS�ɂ�鑽�ϗʉ�́x�� 4 ��
# 1960 �N��̐���ʕ��ϗ]���f�[�^
life <- read.table ("life.txt", row.names = 1)
head (life)

## �K�w�I�N���X�^�[����
# ���������߂�B�f�t�H���g�́u���[�N���b�h�@�v
life.d <- dist (life)
# �N���X�^�[������B�f�t�H���g�͍ŉ��ז@(complete)
life.h <- hclust (life.d)
str (life.h)

# ���ʂ��v���b�g����
plot (life.h, hang = -1)
# ���`�}�̍����B��i�Ō�j����2�ڂ̒l���擾2�Ԗڂ�
height <- tail(life.h$height, 2)[1]
# ������g���Ď��`�}�ɐԂ��j����`��
lines (x = c(0, length (life.h$order)),
       y = rep(height, 2), lty = 2, col = 2)

## �N���X�^�[�̏�����
 # table (cutree (life.h, life.h$height[15] ))

## ��K�w�I�N���X�^�[����
set.seed (123)
km <- kmeans (iris[-5], centers = 3)
table (km$cluster, iris[,5])

# �Ȃ�R-3.1.0��ward�@�̎����ɏC�����������܂����B�C���ł�ward�@�����s����ɂ�method="ward.D2"�Ǝw�肵�܂��B
# �ڍׂ�?hclust�����s���āA�w���v���Q�Ƃ��Ă�������




  ## ----- SECTION 162  ���`���ʕ��͂����s����
# �g�ݍ��݂́u�A�����v�f�[�^���烉���_����80�s���o
set.seed (123)
extract <- sample (1:150, 80)
iris2 <- iris [extract, ]

# ���o�f�[�^���g���Ĕ��ʂ��w�K
library (MASS)
(iris.lda <- lda (Species ~ ., data = iris2))

# �w�K�ɂ�锻�ʌ��ʂ��m�F
table (iris2 [, 5], predict (iris.lda)$class)


plot (iris.lda)
plot (iris.lda, dimen = 1)

iris.lda2 <- predict (iris.lda, iris [-extract, ] )
table (iris [-extract, 5], iris.lda2$class)

# �����Ó���
iris.lda3 <- lda (Species ~ ., data = iris, CV = TRUE)
# ���ʂ��m�F
table (iris [, 5], iris.lda3$class)




  ## ----- SECTION 163  �j���[�����l�b�g���[�N�����s����

library (nnet)
# �g�ݍ��݂́u�A�����v�f�[�^���烉���_����80�s���o
set.seed (123)
extract <- sample(1:150, 80)
iris2 <- iris [extract, ]

# ���o�f�[�^���g���Ċw�K
iris.nn <- nnet (Species ~ ., data = iris2, size = 3)


iris.pre <- predict (iris.nn, iris2, type = "class")
table (iris2[ , 5], iris.pre)


# ���̂��Ă������f�[�^�𕪗�
iris.rest <- iris [-extract, ]
iris.pre2 <- predict (iris.nn, iris [-extract, ], type = "class")
table (iris [-extract, 5], iris.pre2)






  ## ----- SECTION 164 �T�|�[�g�x�N�^�[�}�V�������s����
# �ukernlab�v�p�b�P�[�W��ǂݍ���
library (kernlab)
iris2 <- iris[1:100, ]
iris2$Species <- droplevels (iris2$Species)

# ���o�����u�A�����v�f�[�^���烉���_����50�s���o
set.seed (123)
extract <- sample(1:100, 50)
iris3 <- iris2 [extract, ]

# �P���f�[�^����w�K
iris.train <- ksvm (Species ~ ., data = iris3, kernel = "vanilladot")

# �w�K���ʂ��g���Ďc��f�[�^�𔻕�
iris.test <- predict (iris.train, iris2 [-extract, ] )
table( iris2 [-extract, ]$Species, iris.test)





  ## ----- SECTION 165 ����؂𗘗p����
library (rpart)
# �p��̐Ғ���^�ǂ̗L���f�[�^
nrow (kyphosis)

head (kyphosis)


# �Ǐ�̗L����N��A��p�����ō��̐��A���̈�ԏ�̒ō��̔ԍ�
fit <- rpart (Kyphosis ~ Age + Number + Start,
              data = kyphosis)
# �}������m�F����

par(xpd = NA)
plot(fit, branch = 0.8, margin = 0.05)
text(fit, use.n = TRUE)

# ��肱�݂��K�v�ȏꍇ
z.auto <- rpart (Mileage ~ Weight, car.test.frame)
printcp (z.auto)
plotcp (z.auto)
zp <- prune(z.auto, cp = 0.1)




  ## ----- SECTION 166 ���ȑg�D���}�b�v���쐬����
# install.packages ("kohonen")

library (kohonen)
data (wines)
set.seed (7)

# �P���f�[�^�𒊏o
training <- sample (nrow (wines), 120)
# �W��������
Xtraining <- scale (wines [training, ])
# �e�X�g�f�[�^���P���f�[�^�Ɠ����ړx�ŕW����
Xtest <- scale (wines[-training, ],
                center = attr (Xtraining, "scaled:center"),
                scale = attr (Xtraining, "scaled:scale"))

# �P���f�[�^��5�~5�̃��j�b�g�ɕ��ނ���
som.wines <- som (Xtraining,
                  grid = somgrid (xdim = 5, ydim = 5,
                    topo = "hexagonal"))

# �P�����ʂ��v���b�g
plot (som.wines)

# �����ƑΉ������邽�߁uwine.classes�v�f�[�^�Əƍ�
plot (som.wines, type = "mapping", labels = wine.classes[training], col= wine.classes [training] )



# �e�X�g�f�[�^�𕪗ނ���
som.prediction <- predict(som.wines, newdata = Xtest,
                               trainX = Xtraining,
                               trainY = factor(wine.classes[training]))
table(wine.classes[-training], som.prediction$prediction)




  ## ----- SECTION 167 �x�C�W�A���l�b�g���[�N���͂𗘗p����
#�udeal�v�p�b�P�[�W���C���X�g�[������
install.packages ("deal")
library (deal)
data (ksl)
head (ksl)

# �����l�b�g���[�N���쐬
ksl.nw <- network (ksl)
plot (ksl.nw)

# �����̃m�[�h�̎��O���z���v�Z
ksl.pr <- jointprior (ksl.nw)
# ���O���z����p�����[�^���X�V
ksl.ln <- learn (ksl.nw, ksl, ksl.pr)
# �X�V���ʂ���l�b�g���[�N�I�u�W�F�N�g���擾
ksl.nw <- getnetwork (ksl.ln)
# ����l�b�g���[�N�̐���
ksl.as <- autosearch(ksl.nw, ksl, ksl.pr)

# �l�b�g���[�N���v���b�g����
plot (getnetwork (ksl.as))
print (ksl.as)

# �֑����[���̎w��
# �m�[�h�ԍ����m�F
ksl.nw

(mybanlist <- matrix (c (5, 5, 6, 6, 7, 7,
                         9, 8, 9, 8, 9, 8, 9, 8),
                      ncol = 2))

banlist (ksl.nw) <- mybanlist
ksl.nw2 <- getnetwork (learn (ksl.nw, ksl, ksl.pr))
ksl.as2 <- autosearch (ksl.nw2, ksl, ksl.pr)

# �֑����[���ɊY������ꍇ�Ԃ����ŕ\�������
plot (getnetwork (ksl.as2), showban = FALSE)





  ## ----- SECTION 168  �x�C�Y���v��͂��s��

#�uMCMCpack�v�p�b�P�[�W���C���X�g�[������
install.packages ("MCMCpack")
library(MCMCpack)


# ��
## �哝�̎x���̊���
posterior <- MCmultinomdirichlet(c(727,583,137), c(1,1,1), mc=10000)
class (posterior)
summary (posterior)

plot (posterior)


# MCMCpack �̊֐��ꗗ
# ���܂��܂ȃ��f�����͗p�̊֐�������
ls ("package:MCMCpack")






  ## ----- SECTION 169  �x�C�Y�@�Ő��`��A���͂��s��
# ���`��A���f��
line <- list (X = c (-2,-1,0,1,2), Y = c (1,3,3,3,5))
posterior <- MCMCregress (Y~X, data=line, verbose=1000)

summary (posterior)
raftery.diag (posterior)




  ## ----- SECTION 170 MCMCpack�p�b�P�[�W�Ń��[�U�[��`�̊֐����V�~�����[�V��������

# �T���v�����O�������֐����`
# ���W�X�e�B�b�N�E���f���̑ΐ��ޓx�֐�
logitfun <- function (beta, y, X){
  eta <- X %*% beta
  p <- 1.0/(1.0 + exp (-eta)) # �����N�֐�
                                        # �ΐ��ޓx
  sum(y * log(p) + (1-y)*log (1-p))
}

# �f�[�^
x1 <- rnorm (1000)
x2 <- rnorm (1000)
Xdata <- cbind (1,x1,x2)
p <- exp (.5 - x1 + x2)/(1 + exp (.5 - x1 + x2))

# ��l�f�[�^�̍쐬
yvector <- rbinom (1000, 1, p)
head (yvector)

p <- exp(.5 - x1 + x2) / (1 + exp (.5 - x1 + x2))
# ��l�f�[�^���V�~�����[�V����
yvector <- rbinom (1000, 1, p)

# ���̃f�[�^�Ɩޓx�֐����g���ăT���v�����O���s��  #  ���Ԃ�������܂�
post.samp <- MCMCmetrop1R (logitfun, theta.init=c (0,0,0),
                           X=Xdata, y=yvector,
                           thin=1, mcmc=40000, burnin=500,
                           tune=c (1.5, 1.5, 1.5),
                           verbose=500, logfun=TRUE)

# �T���v�����O�̗v��
summary (post.samp)

dat <- data.frame (cbind (yvector, Xdata))
# ��r�Ƃ��Ĉ�ʉ����`���f���ɂ�錋��
dat.glm <- glm (yvector ~ x1 + x2, data = dat,
                family = binomial (link = "logit"))
summary (dat.glm)








## ----- SECTION 170 RStan�p�b�P�[�W

install.packages("rstan")


N <- 10
y <- c(0,1,0,0,0,0,0,0,0,1)
coinModel <- '
data {
int<lower=0> N;
int<lower=0,upper=1> y[N];
}
parameters {
real<lower=0,upper=1> theta;
}
model {
theta ~ beta(1,1);
for (n in 1:N)
y[n] ~ bernoulli(theta);
}' 

library (rstan)

coinData <- list (N = N, y = y)

fit <- stan(model_code = coinModel, data = coinData, iter = 1000, chains = 4)

fit

traceplot (fit)

fit.ext <- extract(fit, "theta") 
quantile (fit.ext$theta)

# �K�w���f��
schools_code <- '
data {
 int<lower=0> J; // ���Z�̐���\������
 real y[J]; // ���肳�ꂽ����
 real<lower=0> sigma[J]; // ���̕W���덷  
}

parameters {
  real mu;           // �S�̕���
  real<lower=0> tau; // ����
  real eta[J];       // �덷
}
transformed parameters {
  real theta[J];     // ���Z���Ƃ̌���
  for (j in 1:J)     // eta�͍��Z���ƂɈقȂ�덷
    theta[j] <- mu + tau * eta[j];
 }
model {
  eta ~ normal(0, 1);
  y ~ normal(theta, sigma); // �x�N�g�����Z���K�p�����
 }'


# �f�[�^��p��
schools_dat <- list(J = 8, y = c(28,  8, -3,  7, -1,  1, 18, 12), sigma = c(15, 10, 16, 11,  9, 11, 10, 18))


# ���񉻂���
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())


# rstan�ŃT���v�����O
fit <- stan(model_code = schools_code, data = schools_dat, iter = 1000, chains = 4, adapt_delta = 0.81)


# ������ǉ��w��
fit <- stan(model_code = schools_code, data = schools_dat, iter = 1000, chains = 4, control = list(adapt_delta = 0.9))

install.packages("shinystan")

library (shinystan)
launch_shinystan(fit)
