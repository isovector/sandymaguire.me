<link href="https://fonts.googleapis.com/css?family=Roboto|Source+Serif+Pro" rel="stylesheet">


\newenvironment{section}[1]{<div class="section"><h2>#1</h2>}{</div>}
\newenvironment{subsection}[1]{<div class="subsection"><h3>#1</h3>}{</div>}
\newenvironment{job}[2]{<div class="job"><strong>#1</strong><br>\authors{#2}}{</div>}
\newenvironment{when}[1]{<div class="when">#1</div><div class="item">}{</div>}
\newenvironment{itemize}{<ul>}{</ul>}
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
\newcommand{\class}[3]{\begin{when}{#1}<strong>#2</strong> - #3\end{when}}
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
343.262.3363 \spacer sandy@sandymaguire.me \spacer https://reasonablypolymorphic.com
</div>
\end{when}


\begin{section}{Research Interests}
\begin{when}{ }
Functional programming, compiler design, free monads
\end{when}
\end{section}


\begin{section}{Education}
\begin{pointednolink}{2010-2015}{University of Waterloo, Waterloo, ON}{BSE, Software Engineering, Honours, Co-operative Program}
\item{77.16 Cumulative GPA}
\item{Graduated in <emph>Excellent Standing</emph>}
\end{pointednolink}
\begin{subsection}{Classes and Grades}
\class{2015}{Compiler Construction}{92}
\class{2015}{Design Project 2}{89}
\class{2015}{Introduction to Artificial Intelligence}{84}
\class{2015}{Software Testing and Quality Assurance}{76}
\class{2015}{Introduction to Microeconomics}{74}
\class{2015}{Cybernetics and Society}{66}
\class{2014}{Design Project 1}{92}
\class{2014}{Quantum Physics 1}{83}
\class{2014}{Computer Networks}{78}
\class{2014}{Software Design and Architectures}{73}
\class{2014}{Cooperative and Adaptive Algorithms}{72}
\class{2013}{Design Project Planning}{96}
\class{2013}{Operating Systems}{87}
\class{2013}{The Use of English}{86}
\class{2013}{Software Requirements Specification and Analysis}{83}
\class{2013}{Concurrent and Parallel Programming}{75}
\class{2013}{User Interfaces}{74}
\class{2013}{Introduction to Database Management}{71}
\class{2013}{Introduction to the Theory of Computing}{70}
\class{2013}{Numerical Computation}{68}
\class{2013}{Introduction to Feedback Control}{65}
\class{2013}{Algorithms 1}{58}
\class{2012}{Data Structures and Data Management}{80}
\class{2012}{Software Engineering Principles}{75}
\class{2012}{Introduction to Combinatorics}{74}
\class{2012}{Waves, Electricity and Magnetism}{72}
\class{2012}{Advanced Mathematics for Software Engineers}{67}
\class{2012}{Engineering Economics}{67}
\class{2011}{Foundations of Sequantial Programs}{85}
\class{2011}{Chemistry for Engineers}{81}
\class{2011}{Digital Circuits and Systems}{80}
\class{2011}{Functional Programming and Data Abstraction}{79}
\class{2011}{Calculus 2 for Engineering}{76}
\class{2011}{Digital Computers}{75}
\class{2011}{Statistics for Software Engineering}{75}
\class{2011}{Physics of Electrical Engineering 2}{73}
\class{2011}{Introduction to Philosophy}{70}
\class{2011}{Algebra for Honours Mathematics}{62}
\class{2011}{Logic and Computation}{62}
\class{2010}{Linear Algebra for Engineering}{96}
\class{2010}{Programming Principles}{93}
\class{2010}{Physics of Electrical Engineering 1}{86}
\class{2010}{Introduction to Methods of Software Engineering}{85}
\class{2010}{Calculus 1 for Engineers}{78}
\class{2010}{Linear Circuits}{73}
\end{subsection}
\end{section}

\begin{section}{Professional Experience}

\begin{when}{2016-2018}
\begin{job}{Senior Haskell Software Engineer}{Takt}
\begin{itemize}
\item{Led a team of four to reimplement a core subcomponent of the product --- increased the cadence of new feature development from months to days.}
\item{Directed a team of three to implement a high-throughput, low-latency brokered streaming library. Resulting library became the company's core inter-service communication protocol.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2015-2016}
\begin{job}{Engineer III (Identity and Access Management)}{Google}
\begin{itemize}
\item{Led the architectural design effort of a user-defined permission model for the cloud --- the team's only project for the subsequent quarter.}
\item{Took ownership over an unmaintained, service-critical internal compiler; improved compile times by 96\% and test coverage by 65\%.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2014}
\begin{job}{Engineering Intern (Ads Ranking)}{Facebook}
\begin{itemize}
\item{Analyzed the advertising platform's spending behaviors, and subsequently implemented algorithmic changes --- resulting in a 0.5\% revenue increase.}
\item{Parallelized the back-end graph ranker, resulting in site-wide response time gains of 0.4\%.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2013}
\begin{job}{Engineering Intern (FIFA Mobile)}{Electronic Arts Canada}
\begin{itemize}
\item{Single-handedly cleaned up 60\% of the project's technical debt alongside assigned tasks.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2012}
\begin{job}{Gameplay Programmer Intern}{Digital Extremes}
\begin{itemize}
\item{Architected and implemented the game's entire voice-over-IP stack.}
\item{Rewrote a significant portion of the AI and PhysX engines to support arbitrary 3-space rotation.}
\item{Designed and implemented a type-system for the game's proprietary scripting language runtime.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2011}
\begin{job}{.NET Consultant}{Systemgroup Consulting Inc,}
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
\item{Sold over 1,000 copies --- a significant portion of the estimated 10,000 members in the Haskell community.}
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
\conference{2019}{Chasing the Performance of Free Monads}{Lambda Montreal}{Montreal, QC}{ }
\conference{2018}{Existentialization: What Is It Good For?}{Denver FP}{Denver, CO}{\link{slides}{https://reasonablypolymorphic.com/existentialization/}}
\conference{2017}{Some1 Like You: Dependent Pairs in Haskell}{LambdaConf}{Boulder, CO}{\link{video}{https://www.youtube.com/watch?v=PNkoUv74JQU}}
\conference{2017}{Don't Eff It Up: Freer Monads in Action}{BayHac}{San Francisco, CA}{\link{video}{https://www.youtube.com/watch?v=gUPuWHAt6SA}}
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
\dateauthor{2015}{Yelp}{SoftEng Capstone Design Symposium (2nd place)}
\dateauthor{2010}{University of Waterloo}{President's Scholarship}
\end{section}

\pagebreak

\begin{section}{Research Statement}
\begin{when}{ }

\p{
  A friend of mine often jokes that "Haskellers are just early adopters of
  correctness." Despite being tongue-in-cheek, I think he's onto something here.
}

\p{
  My program in university was co-operative, meaning that after each school term
  I was expected to find a job and spend four months excelling out in the "real
  world." Four months is just about as long as it takes most people to start
  feeling comfortable in a new codebase, and as a result, I needed to learn how
  to learn fast.
}

\p{
  It became clear to me that a great deal of human capital was being wasted
  simply trying to reverse-engineer the codebases in which my cohort and I found
  ourselves. The industry prioritizes writing "readable" code, characterized by
  being verbose and "doing nothing clever".  While each step along the way is
  indeed comprehensible, too often this desideratum manages to lose the original
  /intention/ behind the code. There's usually somebody who indeed understands
  the code, but finding that person is often nontrivial.
}

\p{
  Some friends and I decided to solve this. As our graduation capstone project,
  we built an analytics tool to determine /who knows what/ in a codebase. It
  consisted of editor plugins to record what code was being read, by whom. We
  cross-referenced this against diffs, and found that high scores on both
  measures correlated strongly with the team members considered to be "experts"
  in those areas.
}

\p{
  The software would infer dependencies in the codebase by analyzing which
  sections were viewed simultaneously, and emit warnings if they weren't
  logically related. Our tool was useful not only for static analysis, but also
  during debugging. By following experts through their previous jumps from a
  problematic part of the code, we found we could hone in on the issue more
  quickly than other non-experts.
}

\p{
  Our results won us second-place in a project competition hosted by Yelp.
}

\p{
  When you're new to a codebase, it's unclear if the quirky design choices are
  solutions to problems you don't yet understand, or if they're just
  unintentionally bad. In my experience, it's usually the latter. These concerns
  are unsuccessfully assuaged with comments like "well we know it's ugly, but
  we're too afraid to change it" or "it's clearly a ticking time-bomb, but we
  haven't gotten a chance to get around to it."
}

\p{
  I try to live my life by leaving everything a little nicer than I found it,
  and so I decided I should start trying to clean up the dirty code that nobody
  else wanted to touch. It's thankless work --- customers don't see it, and
  management doesn't care, but it makes colleagues' lives better, and that
  seemed worthwhile to me.
}

\p{
  As I fixed more and more technical debt, I started reading between the source
  lines. I saw the abstractions that the original authors were grasping for,
  without realising it. I'd write these abstractions in the course of my
  tidying, and inevitably, my senior colleagues would be using them by the end
  of the week.
}

\p{
  From company to company, people seemed to all be missing the same things.
  They'd write little domain-specific languages to solve their problems, but
  which would immediately balloon into ad-hoc obscurity. They'd copy and paste
  code between files because it wasn't clear exactly how to generalise it.
}

\p{
  Cleaning up bad code is fun for a while, but it gets old rather quickly. It's
  frustrating that today's mainstream tools are simply failing people who want
  to write better code. These people find often themselves between doing the
  /right/ thing and doing a /quick/ thing. Every incentive structure prioritizes
  the latter. But personally, I don't think our tools should punish people for
  attempting to write good code.
}

\p{
  I became interested in free monads at my last company, where our code was an
  impressively tangled ball of spaghetti. It was untestable, and so people
  simply didn't write any tests. A stupid bug made it into production, and it
  cost us a few million dollars. Several people were subsequently let go, a few
  of whom were good friends of mine. All of this seemed so preventable, and I
  started looking for a solution.
}

\p{
  As I dug in, I realized that free monads were the abstraction that /I/ had
  been grasping for without realizing. They allowed me to express my ideas at a
  very high-level. They let me separate my implementation details from my
  business logic, and as a bonus, I could turn those details into library code.
  It let me write code at a faster rate than my peers, and it was easy to prove
  correct.
}

\p{
  Despite my best attempts at proselytizing free monads, my communities simply
  didn't engage. Try as I might, people pushed back against the idea. They
  correctly argued that free monads didn't deliver on their promise of static
  analysis; they correctly argued that free monads were too slow to be
  practical.
}

\p{
  So long as people had valid complaints, they simply wouldn't listen to how
  free monads could help. I decided to do something about it.
}

\p{
  Following the work of Foner et al.'s work on StrictCheck, I realized a similar
  approach of carefully passing bottoms around could be used to plumb through
  binds in free monads. The result was novel, and allowed many classes of free
  Kleisli morphisms to be inspected statically --- an idea previously considered
  impossible.
}

\p{
  The performance problem however was more taxing. While Wu and Schrijvers have
  shown that efficient free monads are possible, their technique requires users
  to write a significant amount of boilerplate --- something I knew would be a
  stumbling block to wide adoption. If something is too much work to do write,
  people simply won't do it. After several months of work, I came up with a
  solution that could give free implementations of the boilerplate, at the
  expense of making the compiler work harder. Unfortunately, the compiler wasn't
  up to the challenge, so I had to patch it. The code review is still in
  process, but my local branch allows for free monads to be a true zero-cost
  abstraction.
}

\p{
  I really and truly believe that useable free monads will drastically improve
  code "out in the wild." They'll lessen the frequency of newcomers flailing
  around in codebases. Perhaps most importantly, they'll cut down on the frantic
  four-in-the-morning broken-code alarms that are too prevalent in the industry.
}

\p{
  Alleviating these pain points seems like the most important thing I can be
  working on, and I'm determined to do whatever I must in order to make that
  dream a reality.
}

\end{when}
\end{section}

<p>&nbsp;</p>

