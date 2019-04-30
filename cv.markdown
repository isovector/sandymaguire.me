<link href="https://fonts.googleapis.com/css?family=Roboto|Source+Serif+Pro" rel="stylesheet">


\newenvironment{section}[1]{<div class="section"><h2>#1</h2>}{</div>}
\newenvironment{subsection}[1]{<div class="subsection"><h3>#1</h3>}{</div>}
\newenvironment{job}[2]{<div class="job"><strong>#1</strong><br>\authors{#2}}{</div>}
\newenvironment{when}[1]{<div class="when">#1</div><div class="item">}{</div>}
\newenvironment{itemize}{<ul>}{</ul>}
\newenvironment{classes}[1]{\begin{when}{#1}<div class="classes">}{</div>\end{when}}
\newcommand{\dateauthor}[3]{<div class="when">#1</div><div class="item"><strong>#3</strong><br>\authors{#2}</div>}
\newcommand{\conference}[5]{<div class="when">#1</div><div class="item"><strong>#2</strong> #5<br>\authors{#3 \spacer #4}</div>}
\newcommand{\education}[4]{<strong>#1, #2</strong><br>\authors{#3, #4}</item>}
\newcommand{\me}{Sandy Maguire}
\newcommand{\item}[1]{<li>#1</li>}
\newcommand{\%}{&#37;}
\newcommand{\authors}[1]{<span class="authors"><em>#1</em></authors>}
\newcommand{\opensource}[3]{<div class="when">#1</div><div class="item"><strong>#2/#3</strong> <a href="https://github.com/#2/#3">[link]</a></div>}
\newcommand{\myopensource}[4]{<div class="when">#1</div><div class="item"><strong>#2/#3</strong> <a href="https://github.com/#2/#3">[link]</a><br><span
class="desc">#4</span></div>}
\newenvironment{pointed}[4]{<div class="when">#1</div><div class="item"><strong>#3</strong> <a href="#4">[link]</a><br>\authors{#2}<br>\begin{itemize}}{\end{itemize}</div>}
\newenvironment{pointednolink}[3]{<div class="when">#1</div><div class="item"><strong>#3</strong><br>\authors{#2}<br>\begin{itemize}}{\end{itemize}</div>}
\newcommand{\link}[2]{<a href="#2">[#1]</a>}
\newcommand{\color}{#999}
\newcommand{\spacer}{&nbsp;&bull;&nbsp;}
\newcommand{\class}[2]{#1 (#2) \spacer}
\newcommand{\lastclass}[2]{#1 (#2)}
\newcommand{\pagebreak}{<div class="break"></div>}
\newcommand{\p}[1]{<p>#1</p>}

<style type="text/css">
body {
  font-size: 12pt;
  width: 55em;
  font-family: 'Source Serif Pro', serif;
  text-align: justify;
  line-height: 16pt;
}

.classes {
text-align: left;
}

.break {
page-break-after: always;
}

.deets {
  font-size: smaller;
  line-height: 12pt;
}

h1 {
  margin-top: 1em;
  font-size: 59.5pt;
  margin-left: 1.38em;
  margin-bottom: 0.45em;
  font-family: 'Roboto', sans-serif;
  font-variant: small-caps;
}

.authors {
display: block;
margin-top: 0.1em;
margin-bottom: 0.3em;
page-break-after: avoid;
}

ul {
  margin-top: 0.2em;
  padding-left: 1.2em;
}

.when {
  float: left;
  text-align: right;
  width: 6em;
  font-size: 12pt;
  color: \color;
}
.item {
  margin-left: 7em;
  margin-bottom: 0.7em;
}

li {
  margin-bottom: 0.2em;
page-break-after: avoid;
}

a {
  color: \color;
  font-size: 10pt;
  margin-left: 0.2em;
}

div.section {
  margin-top: 4em;
}

h2 {
  color: \color;
margin-top: 2em;
font-size: 18pt;
margin-left: 4.6em;
  font-family: 'Roboto', sans-serif;
}

h3 {
  color: \color;
font-size: 14.5pt;
margin-left: 5.75em;
margin-bottom: 0.5em;
  font-family: 'Roboto', sans-serif;
}

div.subsection {
margin-top: 2em;
}
</style>

<h1>Sandy Maguire</h1>
\begin{when}{ }
<div class="deets">
(+1) 343.262.3363 \spacer sandy@sandymaguire.me \spacer https://reasonablypolymorphic.com
</div>
\end{when}


\begin{section}{Research Interests}
\begin{when}{ }
Functional programming, compiler design, free monads
\end{when}
\end{section}


\begin{section}{Education}
\begin{pointednolink}{2010-2015}{University of Waterloo, Waterloo, ON, Canada}{BSE, Software Engineering, Honours, Co-operative Program}
\item{77.16 Cumulative GPA}
\item{Graduated in <emph>Excellent Standing</emph>}
\end{pointednolink}
\begin{subsection}{Classes and Grades}
\begin{classes}{2015}
\class{Compiler Construction}{92}
\class{Design Project 2}{89}
\class{Introduction to Artificial Intelligence}{84}
\class{Software Testing and Quality Assurance}{76}
\class{Introduction to Microeconomics}{74}
\lastclass{Cybernetics and Society}{66}
\end{classes}
\begin{classes}{2014}
\class{Design Project 1}{92}
\class{Quantum Physics 1}{83}
\class{Computer Networks}{78}
\class{Software Design and Architectures}{73}
\lastclass{Cooperative and Adaptive Algorithms}{72}
\end{classes}
\begin{classes}{2013}
\class{Design Project Planning}{96}
\class{Operating Systems}{87}
\class{The Use of English}{86}
\class{Software Requirements Specification and Analysis}{83}
\class{Concurrent and Parallel Programming}{75}
\class{User Interfaces}{74}
\class{Introduction to Database Management}{71}
\class{Introduction to the Theory of Computing}{70}
\class{Numerical Computation}{68}
\class{Introduction to Feedback Control}{65}
\lastclass{Algorithms 1}{58}
\end{classes}
\begin{classes}{2012}
\class{Data Structures and Data Management}{80}
\class{Software Engineering Principles}{75}
\class{Introduction to Combinatorics}{74}
\class{Waves, Electricity and Magnetism}{72}
\class{Advanced Mathematics for Software Engineers}{67}
\lastclass{Engineering Economics}{67}
\end{classes}
\begin{classes}{2011}
\class{Foundations of Sequantial Programs}{85}
\class{Chemistry for Engineers}{81}
\class{Digital Circuits and Systems}{80}
\class{Functional Programming and Data Abstraction}{79}
\class{Calculus 2 for Engineering}{76}
\class{Digital Computers}{75}
\class{Statistics for Software Engineering}{75}
\class{Physics of Electrical Engineering 2}{73}
\class{Introduction to Philosophy}{70}
\class{Algebra for Honours Mathematics}{62}
\lastclass{Logic and Computation}{62}
\end{classes}
\begin{classes}{2010}
\class{Linear Algebra for Engineering}{96}
\class{Programming Principles}{93}
\class{Physics of Electrical Engineering 1}{86}
\class{Introduction to Methods of Software Engineering}{85}
\class{Calculus 1 for Engineers}{78}
\lastclass{Linear Circuits}{73}
\end{classes}
\end{subsection}
\end{section}

\begin{section}{Professional Experience}

\begin{when}{2016-2018}
\begin{job}{Senior Haskell Software Engineer}{Takt \spacer San Francisco, CA, USA}
\begin{itemize}
\item{Led a team of four to reimplement a core subcomponent of the product &mdash; increased the cadence of new feature development from months to days.}
\item{Directed a team of three to implement a high-throughput, low-latency brokered streaming library. Resulting library became the company's core inter-service communication protocol.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2015-2016}
\begin{job}{Engineer III (Identity and Access Management)}{Google \spacer Mountain View, CA, USA}
\begin{itemize}
\item{Led the architectural design effort of a user-defined permission model for the cloud &mdash; the team's only project for the subsequent quarter.}
\item{Took ownership over an unmaintained, service-critical internal compiler; improved compile times by 96\% and test coverage by 65\%.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2014}
\begin{job}{Engineering Intern (Ads Ranking)}{Facebook \spacer Menlo Park, CA, USA}
\begin{itemize}
\item{Analyzed the advertising platform's spending behaviors, and subsequently implemented algorithmic changes &mdash; resulting in a 0.5\% revenue increase.}
\item{Parallelized the back-end graph ranker, resulting in site-wide response time gains of 0.4\%.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2013}
\begin{job}{Engineering Intern (FIFA Mobile)}{Electronic Arts Canada \spacer Burnaby, BC, Canada}
\begin{itemize}
\item{Single-handedly cleaned up 60\% of the project's technical debt alongside assigned tasks.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2012}
\begin{job}{Gameplay Programmer Intern}{Digital Extremes \spacer London, ON, Canada}
\begin{itemize}
\item{Architected and implemented the game's entire voice-over-IP stack.}
\item{Rewrote a significant portion of the AI and PhysX engines to support arbitrary 3-space rotation.}
\item{Designed and implemented a type-system for the game's proprietary scripting language runtime.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2011}
\begin{job}{.NET Consultant}{Systemgroup Consulting Inc. \spacer Mississauga, ON, Canada}
\begin{itemize}
\item{Found and closed over ten highly-exploitable vulnerabilities in a multi-billion-dollar company's website.}
\end{itemize}
\end{job}
\end{when}
\end{section}


\begin{section}{Publications}
\begin{subsection}{Books}
\begin{pointed}{2018}{\me, self-published}{Thinking with Types: Type-Level Programming in Haskell}{https://thinkingwithtypes.com/}
\item{Favourably reviewed; described as being "well written and very approacable", "absolutely brilliant," and "a great read."}
\item{Sold over 1,000 copies &mdash; a significant portion of the estimated 10,000 members in the English-speaking Haskell community.}
\end{pointed}

\begin{pointed}{2016}{\me, self-published}{How These Things Work}{https://reasonablypolymorphic.com/book/preface}
\end{pointed}
\end{subsection}

\begin{subsection}{Blog}
\begin{pointed}{2015-}{\me}{Reasonably Polymorphic}{https://reasonablypolymorphic.com}
\item{Professional and research blog.}
\end{pointed}
\end{subsection}
\end{section}


\begin{section}{Presentations}
\conference{2019}{Chasing the Performance of Free Monads}{Lambda Montreal}{Montreal, QC, Canada}{ }
\conference{2018}{Existentialization: What Is It Good For?}{Denver FP}{Denver, CO, USA}{\link{slides}{https://reasonablypolymorphic.com/existentialization/}}
\conference{2017}{Some1 Like You: Dependent Pairs in Haskell}{LambdaConf}{Boulder, CO, USA}{\link{video}{https://www.youtube.com/watch?v=PNkoUv74JQU}}
\conference{2017}{Don't Eff It Up: Freer Monads in Action}{BayHac}{San Francisco, CA, USA}{\link{video}{https://www.youtube.com/watch?v=gUPuWHAt6SA}}
\end{section}


\begin{section}{Open Source Contributions}
\begin{subsection}{Maintainer}
\myopensource{2019-}{isovector}{polysemy}{Higher-order, no-boilerplate, zero-cost free monad library.}
\myopensource{2019-}{isovector}{suavemente}{An applicative functor capable of talking directly to HTML inputs.}
\myopensource{2018-}{isovector}{do-notation}{Generalized do-notation for indexed monads.}
\myopensource{2018-}{isovector}{latex-live-snippets}{Keep code snippets up to date in LaTeX documents.}
\myopensource{2018-}{isovector}{constraints-emerge}{Runtime reification of Haskell's instance resolution machinery.}
\myopensource{2018-}{isovector}{ecstasy}{A boilerplate-free entity component system library.}
\myopensource{2017-}{isovector}{th-dict-discovery}{Compile-time reification of every typeclass instance in scope.}
\myopensource{2017}{TaktInc}{freer}{Corporate fork of a freer monad library.}
\end{subsection}

\begin{subsection}{Contributor}
\myopensource{2019}{Lysxia}{first-class-families}{A library for higher-order type-level programming in Haskell.}
\myopensource{2017}{kim}{opentracing}{Haskell implementation of the OpenTracing instrumentation API.}
\myopensource{2017}{google}{proto-lens}{API for protocol buffers using modern Haskell language and library patterns.}
\myopensource{2017}{IxpertaSolutions}{freer-effects}{A free monad library in the style of "Freer Monads, More Extensible Effects."}
\myopensource{2017}{k0001}{exinst}{An implementation of sigma types in Haskell.}
\end{subsection}

\begin{subsection}{Committer}
\myopensource{2018}{nomeata}{inspection-testing}{Automated testing of Haskell's Core representations.}
\myopensource{2018}{AshleyMoni}{QuadTree}{QuadTree library for Haskell, with lens support.}
\myopensource{2018}{conal}{concat}{A GHC plugin to compile Haskell to constrained categories.}
\myopensource{2018}{diagrams}{diagrams-contrib}{User contributed extensions to diagrams.}
\end{subsection}
\end{section}


\begin{section}{Honours, Awards and Scholarships}
\dateauthor{2015}{Yelp \spacer Waterloo, ON, Canada}{SoftEng Capstone Design Symposium (2nd place)}
\dateauthor{2010}{University of Waterloo \spacer Waterloo, ON, Canada}{President's Scholarship}
\end{section}

\pagebreak

\begin{section}{Research Statement}
\begin{when}{ }

\p{
  My program in university was co-operative; after each school term
  I was expected to find and work a job for four months. Four months is just
  about as long as it takes most people to start feeling comfortable in a new
  codebase, and as a result, I needed to learn how to learn fast.
}

\p{
  It became clear to me that a great deal of human capital was being wasted
  simply trying to reverse-engineer these codebases.
  The industry prioritizes writing "readable" code, characterized by
  being verbose and "doing nothing clever". While each step along the way is
  indeed comprehensible, too often this desideratum manages to lose the original
  <i>intention</i> behind the code.
}


\p{
  Some friends and I decided to solve this. As our graduation capstone project,
  we built an analytics tool to determine <i>who knows what</i> in a codebase.
  By correlating commit information with between what code was physically
  on-screen, we found that we could outperform other contributors on both
  debugging and refactoring. Our results won us second-place in a project
  competition hosted by Yelp.
}

\p{
  At my last company our code was an impressively tangled, untestable ball of
  spaghetti. A stupid bug made it into production, and it cost us a few million
  dollars. I started looking for a preventative solution, and came across free
  monads.
}

\p{
  Free monads are a technique that allow for a separation of syntax from
  semantics. They allow you to quickly define a domain-specific language (DSL)
  appropriate for the problem at hand, and later provide interpretations for
  what that DSL means. These interpretations need not be unique, and can be
  composed at will. Different interpretations can provide dramatically different
  artifacts from the same code.
}

\p{
  Free monads, as they exist today, have a problem in the face of polymorphism.
  While nothing in principle prevents their DSLs from being polymorphic, the
  ergonomics around doing so are frustrating. Usages that are perfectly clear to
  humans are nevertheless ambiguous to the compiler. I want to develop a
  compiler plugin which is capable of resolving these ambiguities, by extending
  the unification algorithm to play nicely with polymorphic DSLs.
}

\p{
  In 2018, I realized I could take the approach of carefully evaluating only as
  much of a program as was necessary. In doing so, I could plumb through free
  monads, and perform static analysis on many things previously considered
  impossible.
}

\p{
  Historically, free monads have had problems with performance. Wu and
  Schrijvers have shown that efficient free monads are possible, though their
  technique requires a significant amount of boilerplate. I came up with a
  solution that could give free implementations of the boilerplate, at the
  expense of making the compiler's optimiser work harder. My work allows for
  free monads to be a true zero-cost abstraction, without the need for any
  tedious boilerplate.
}

\p{
  The zero-cost performance gains found here are impressive, though unreliable.
  The process requires the compiler to have total knowledge of the whole
  program, and requires hand-written annotations in order of having any chance
  of successfully optimizing the problem away. My results are a promising
  proof-of-concept; a robust solution will likely require finding an object-code
  format amenable to describing the DSLs as first-class concepts.
}

\p{
  Last year I wrote a book on type-level programming in Haskell. I wrote the
  copy in LaTeX, which came back to haunt me when I decided to publish an ebook
  alongside the print version.  While LaTeX provides an ergonomic writing
  environment, and makes it easy to spin up new abstractions, it doesn't give
  any tools to allow for different interpretations. For example, an ebook simply
  doesn't have the screen real-estate for a sidebar. This is an area in which
  I'd love to use free monads, but doing so will require better ergonomics for
  using them in non-programming domains.
}

\p{
  HTML is a successful document format, which makes the distinction between
  block and inline elements. Block elements may contain inline elements and
  other blocks, but inline ones may contain only other inline elements. Despite
  their advances over first-order effects, scoped effects are still not yet
  capable of modeling HTML elements. In my view, this restriction is rather
  embarrassing. It's caused by a lacking reification of the DSL capabilities
  <i>inside</i> a scoped effect. I don't think this is a fundamental limitation
  of the approach, merely one that could use some thinking.
}

\p{
  Finally, free monads strike me as having many desirable properties in
  knowledge work. The recent popularity of Jupyter notebooks suggests to me that
  not only do people want to give answers, but also show the means by which they
  were computed. But these are just two interpretations of the same thing! I
  dream of a day when all of our ad-hoc decision making is reified into data, to
  be reinterpreted at will. The implications for policy-making and transparent
  governance are especially staggering, and I'd like to do everything in my
  power to help make that future a reality.
}

\end{when}
\end{section}

