# Mathemathics

## Probability

### Binomial distribution

For a variable with two values  (gender, coin, ...), the binomial distribution gives the probability of having a combination of independent events knowing the probability of one single event.

For example, for a variable with two value F (False) and T (True), knowing that the probablity of F is for instance 0.38, we can commpute the probability of having n times F and m times T.

### Poisson distribution

--> based on Binomial distribution.
--> compute the probability of a rare event to occur when repeated multiple times.

### Hypergeometric distribution

Used to compute the probability of events for two categorical variables when the samples are very small.

### Standard normal distribution (the bell curve)

Aka: Gauss distribution or DeMoivre distribution.

Used for continuous variables.

The standard normal z variable has:
 * A mean of 0.
 * A standard deviation of 1.
 * Values from -inf to +inf.
Area under the curve represent the probability of z => Total area = 1.

The probability of having the value x or more is called the p-value.

### t distribution (Student's t)

This is a family of distributions, parameterized by the df (degree of freedom) number.
The t-distribution looks like the normal distribution, except it is lower in the middle and higher at the edges.
The higher the degree of freedom, the closer the t-distribution is to the normal distribution. For df > 100, the normal distribution can be used instead.

### Chi-square distribution

This is a family of distributions, parameterized by the df (degree of freedom) number.
The curve is asymmetrical (i.e.: the distribution is skewed), with the bell on the left.
The chi-square variable is only positive (from 0 to infinity).
Total area under the curve = 1.

### F distribution

This is a family of distributions, parameterized by the df (degree of freedom) number.

## Statistics & machine learning

### Glossary

The **supervised learning** supposes the presence of an outcome variable inside the set of measured variables. A prediction model, or learner, is built from this set of variable. It is then used to predict the outcome of a new set of variables. In the **unsupervised learning**, no outcome variable is provided, the goal is then to describe how the data are organized or clustered [see @stat, p. 2].

A **classification problem** is a **supervised learning** in which we try determine the class of an input. For instance in a spam detection software [see @stat, p. 2], based on some values measured on an email, we try to determine if it is a spam or not. The outcome is *qualitative*.

A **regression problem** is a **supervised learning** in which we try to determine correlation between input variables to predict the value of an outcome variable [see @stat, p. 3]. The outcome is *quantitative*.

Input variables = predictors = independent variables = features.
Output variables = responses = dependent variables.
Qualitative variables = categorical variables = discrete variables = factors.
Ordered categorical variable = some qualitative variable whose values are ordered (e.g.: small, medium, big).

Méthodes explicatives:
	On cherche à relier une variable Y aux autres.
	Y = f(X1,...Xk) + aléa

Méthodes descriptives:
	On cherche à classer les individus ou les variables Xk en groupes.

Méthodes prédictives:
	On cherche à prédire temporellement une variable, par rapport à ses valeurs passées.
	Xt = f(Xt-1, Xt-2, ...) + aléa

Variable qualitative:
	Une variable qualitative ne peut prendre qu'un nombre fini de valeurs (oui/non, ensemble de couleurs, jours de la semaine, ...). C'est l'équivalent d'un type énuméré.
	Pour la décrire, on utilise le décompte des occurrences des modalités (i.e.: valeurs énumérées) prises par la variable.
	On réalise donc un histrogramme de la variable sur un ensemble d'individus.

Variable quantitative:
	Une variable de type numérique.

### Modal value (or mode) of variable

For a categorical variable, the mode is the main category (the one with the most occurrences).

For a numeric value like the age, we take the value is most represented. Or we have age ranges, we take the range that is most represented, for example 23-30, and we take the mean, 26.5.

mode = principal value for a 
bimodal

### Boxplot

The boxplot divides the values in four sets containing each one quarter of the whole data.
The rectangle contains 1/2 of the values.

	            _____________________________________
	|    1/4    |         |                         |                     1/4                     |
	|-----------|   1/4   |          1/4            |---------------------------------------------|
	|           |_________|_________________________|                                             |

### Median

The median is the number that divides the set of values in two sets of the same size.
If there is an odd number of values, then the median is one of the values.
If there is an even number of values, then the median is between two of the values, and we take the mean of those two values for the median.

### Range

Range = max - min

Interquartile range = range of the observations when the smallest 25% and the largest of the 25% of the data are dropped.
                    = rectangle of the boxplot.

### Standard deviation (and variance)

standard deviation = average distance from the mean
                   = sqrt( sum( (x(i) - mean)^2 ) / (N - 1) )

The variance is a measure of how far a set of numbers is spread out.

The variance of a random variable X is:
var(X) = E((X - E(X))²)
       = E(X² -2XE(X) +E²(X))
       = E(X²) -2E(XE(X)) +E²(X)
       = E(X²) -2E(X)E(X) +E²(X)
       = E(X²) -2E²(X) +E²(X)
       = E(X²) - E²(X)

If x is a one dimensional array, of N elements, and m is its mean, then the variance is:
var = sum(x(i)^2 - m^2) / N
    = sum(x(i)^2) / N - m^2

In software, we use the formulae:
var = sum(x(i)^2 - M(x)^2) / (N-1)
where M(x) is the computed mean of xi variables, and not the real mean. M(x) is lower than m, and thus using N-1 instead of N allows a better approximation of the variance.

The standard deviation (écart-type in French) is :
std = sqrt(var)

### Standard error

We suppose we have 10 sets of the same observations.
We want to know if the 10 sets are alike, or if they are different.
For that we compute for instance the mean of each set.
The standard error of the means is the standard deviation of these means.
If the standard error is small, then this means the sets are quite similar.

### Standard score

The standard score is used to compare two different variables.
For instance: the ages of two different categories.

The standard score of an observation x is : (x - mean) / std

### Expected value

Expected value or expectation or mean (or "Espérance mathématique" or "valeur moyenne" in French) of a random variable:

For a random variable X | { P(X = xi) | i∈N }
       ∞
E(X) = ∑ xiP(X=xi)
      i=1

### Linear regression

 * [Linear regression](https://en.wikipedia.org/wiki/Linear_regression).
 * [Multiple Linear Regression](http://dept.stat.lsa.umich.edu/~kshedden/Courses/Stat401/Notes/401-multreg.pdf).

Y = β * X

Simple linear regression = when X and Y are scalar
Multiple linear regression = when X is a vector and Y a scalar. β is a vector.
General linear regression = when X is a vector, and Y a vector. β is a matrix.
***TODO***: what's the name when X and Y are matrices ?

### Pearson correlation

The Pearson product-moment correlation coefficient is a measure of the linear correlation between two variables.
It gives a value between -1 and +1 inclusive.
0   no correlation.
+1  total positive correlation.
-1  total negative correlation.


ρ(X,Y) = cov(X,Y) / (σ(X).σ(Y))

	where cov is the covariance and σ(X) is the standard deviation of X.

### Spearman correlation

Allows to compare two variables (i.e.: set of values) without relying on the values themsevles, but rather on the rank they have inside an ordered list.
A Spearman correlation of +1 means that the two variables are (increasing) monotone functions of the other. And -1 means an decreasing monotone function.

Example : a vector of values 0,10,0,40,15,20,30, once replaced by the ranks of its values, will become 0,1,0,5,2,3,4.

The Spearman correlation coefficient is the Pearson correlation coefficient between the RANKED variables. See pearson_correlation.txt

### Measures of a variable

#### Mean

i = 1 .. n
M = sum(x(i)) / n

#### Mediane

La série xi est ordonnée et croissante.
On utilise le(s) valeur(s) qui sépare(nt) le groupe de données en deux groupes de tailles égales.
i = 1 .. n
si n = 2k+1 alors M = x(k+1)
si n = 2k   alors M = (x(k) + x(k+1)) / 2

#### Mesure de la dispersion etendue

W = max(x(i)) - min(x(i))

#### Quartiles

Les quartiles (Q1,Q2,Q3) sont des valeurs qui partagent en quatre parties d'effectifs égaux la série de valeurs observées.
La série doit être classée par ordre non décroissant.

Q2 est la médiane M (voir mediane.txt).

Distance interquartiles:
	H = Q3 - Q1

#### Diagramme cumulatif

Il consiste à tracer (x(i), i) où x(i) est un série de valeurs non décroissantes.

#### Histrogramme

Pour une VARIABLE QUALITATIVE, cela consiste à compter le nombre d'occurences des valeurs de la variable pour l'ensemble des individus.

Pour une VARIABLE QUANTITATIVE, on divise l'intervalle de variation (intervalle des valeurs possibles de la variable) en k classes.

### Neural Networks

 * [Spiking neural model](http://cortex.cs.may.ie/theses/chapters/chapter4.pdf).
 * [Polychronization: Computation with Spikes](http://www.izhikevich.org/publications/spnet.pdf).
 * [A biologically inspired model of motor control of direction](http://cortex.cs.may.ie/papers/IoanaMarianMScThesis.pdf), thesis.

### Linear methods

#### Linear models and least squares method

[see @stat, pp. 11-14].

The linear model makes huge assumptions about structure and yields stable but possibly inaccurate predictions. 

#### Nearest neighbors methods

[see @stat, pp. 14-16].

The method of k-nearest neighbors makes very mild structural assumptions: its predictions are often accurate but can be unstable.

#### LDA (Linear Discriminant Analysis)

Linear discriminant analysis (LDA) and the related Fisher's linear discriminant are methods used in statistics, pattern recognition and machine learning to find a linear combination of features which characterize or separate two or more classes of objects or events. The resulting combination may be used as a linear classifier, or, more commonly, for dimensionality reduction before later classification.

#### PCA (Principal Component Analysis)

PCA is a linear projection method.

 * [Principal component analysis](https://en.wikipedia.org/wiki/Principal_component_analysis).

### Non-linear projection methods

#### CDA (Curvilinear Distance Analysis)

CDA is non-linear projection method.

  * [Curvilinear Distance Analysis](https://www.elen.ucl.ac.be/neural-nets/Research/CDA/CDA.htm).

### Voronoi cells

 * [Voronoi diagram](https://en.wikipedia.org/wiki/Voronoi_diagram).

## Combinatorics

### Arrangements without repetitions

k objects among n.

 k
A  = A(n,k) = n! / (n-k)!
 n

### Arrangements with repetitions

n^k

### Combinations without repetitions

⎧  ⎫    k
⎜ n⎢ = C  = C(n,k) = A(n,k) / k!
⎟ k⎢    n
⎩  ⎭

### Combinations with repetitions

⎧          ⎫
⎜ n + k - 1⎢
⎟     k    ⎢
⎩          ⎭

## Algebra

#### Determinant of a matrix

### Determinant of a 2x2 matrix

    ⎡ a11 a12⎤
M = ⎣ a21 a22⎦

det(M) =  a11a22-a12a21

### Determinant of a 3x3 matrix

   ⎡ a11 a12 a13⎤
M =⎪ a21 a22 a23⎪
   ⎣ a31 a32 a33⎦

det(M) = a11(a33a22-a32a23) - a21(a33a12-a32a13) + a31(a23a12-a22a13)

### Inverse of a matrix

#### Lemme d'inversion matricielle

(A+BCD)^-1 = ...

Cas particulier:
A+v.transpose(v))^-1 = A^-1 - (A^-1.v.transpose(v).A^-1) / (1 + transpose(v).A^-1.v)
	
#### Inverse of a 2x2 matrix

    ⎡ a11 a12⎤
M = ⎣ a21 a22⎦

                 ⎡  a22 -a12⎤
M⁻¹ = 1/det(M) * ⎣ -a21  a11⎦

#### Inverse of a 3x3 matrix

   ⎡ a11 a12 a13⎤
M =⎪ a21 a22 a23⎪
   ⎣ a31 a32 a33⎦

                 ⎡   a33a22-a32a23  -(a33a12-a32a13)   a23a12-a22a13  ⎤
M⁻¹ = 1/det(M) * ⎪ -(a33a21-a31a23)   a33a11-a31a13  -(a23a11-a21a13) ⎪
                 ⎣   a32a21-a31a22  -(a32a11-a31a12)   a22a11-a21a12  ⎦

### Sum

  n
  ∑ i  = n(n+1)/2
i = 0

## Geometry

### 2D

#### Vector

The vector orthogonal to V=(a,b) is U=(b,-a)
V.U = 0

#### Polygon

 * [Area of a polygon](http://www.mathopenref.com/coordpolygonarea.html).
