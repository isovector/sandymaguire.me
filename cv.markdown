<link href="https://fonts.googleapis.com/css?family=Merriweather|Source+Serif+Pro" rel="stylesheet">


\newenvironment{section}[1]{<div class="section"><h2>#1</h2>}{</div>}
\newenvironment{subsection}[1]{<div class="subsection"><h3>#1</h3>}{</div>}
\newenvironment{job}[2]{<div class="job"><strong>#1, #2</strong>}{</div>}
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
\newcommand{\link}[2]{<a href="#2">[#1]</a>}
\newcommand{\color}{#999}
\newcommand{\spacer}{&nbsp;&bull;&nbsp;}

<style type="text/css">
body {
  font-size: 10pt;
  width: 45em;
  font-family: 'Source Serif Pro', serif;
  text-align: justify;
  line-height: 16pt;
}

.deets {
  font-size: smaller;
  line-height: 12pt;
}

h1 {
  margin-top: 1em;
  font-size: 43pt;
  margin-left: 1.62em;
  margin-bottom: 0.45em;
}

ul {
  margin-top: 0.2em;
  padding-left: 1.2em;
}

.when {
  float: left;
  text-align: right;
  width: 6em;
  font-size: 10pt;
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
  font-size: 8pt;
  margin-left: 0.2em;
}

div.section {
  margin-top: 4em;
}

h2 {
  color: \color;
margin-top: 2em;
font-size: 15pt;
margin-left: 4.6em;
}

h3 {
  color: \color;
font-size: 12pt;
margin-left: 5.8em;
margin-bottom: 0.2em;
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
\begin{when}{2010-2015}
\education{BSE}{Software Engineering, Honours, Co-operative Program}{University of Waterloo}{Waterloo, ON, Canada}
\end{when}
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
\item{Led the architectural design effort of a user-defined permission model for the cloud – the team's only project for the subsequent quarter.}
\item{Took ownership over an unmaintained, service-critical internal compiler; improved compile times by 96\% and test coverage by 65\%.}
\end{itemize}
\end{job}
\end{when}

\begin{when}{2014}
\begin{job}{Engineering Intern (Ads Ranking)}{Facebook}
\begin{itemize}
\item{Analyzed the advertising platform's spending behaviors and subsequently implemented algorithmic changes resulting in a 0.5\% revenue increase.}
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
\begin{pointed}{2018}{\me}{Thinking with Types: Type-Level Programming in Haskell}{https://thinkingwithtypes.com/}
\item{Favourably reviewed; described as being "well written and very approacable", "absolutely brilliant," and "a great read."}
\item{Sold over 1,000 copies --- a significant portion of the estimated 10,000 members in the Haskell community.}
\end{pointed}

\begin{pointed}{2016}{\me}{How These Things Work}{https://reasonablypolymorphic.com/book/preface}
\end{pointed}
\end{subsection}

\begin{subsection}{Blog}
\begin{pointed}{2015-}{\me}{Reasonably Polymorphic}{https://reasonablypolymorphic.com}
\item{Professional and research blog.}
\end{pointed}
\end{subsection}
\end{section}


\begin{section}{Research}
\dateauthor{2019}{\me}{Higher-Order, No-Boilerplate, Zero-Cost Monads}
\dateauthor{2018}{\me}{Static Analysis of Free Monads}
\dateauthor{2015}{\me, Matt Maclean, Adam Sils, Jeff Lee, Austin Dobrik}{Real-Time Knowledge Tracking in Codebases}
\dateauthor{2015}{Lucas Wojciechowski, Ariel Weingarten, \me, Dane Carr, Austin Dobrik}{Complex Task Allocation: A Comparison of Metaheuristics}
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
\opensource{2019}{Lysxia}{first-class-families}
\opensource{2017}{kim}{opentracing}
\opensource{2017}{google}{proto-lens}
\opensource{2017}{IxpertaSolutions}{freer-effects}
\opensource{2017}{k0001}{exinst}
\end{subsection}

\begin{subsection}{Committer}
\opensource{2018}{nomeata}{inspection-testing}
\opensource{2018}{AshleyMoni}{QuadTree}
\opensource{2018}{conal}{concat}
\opensource{2018}{diagrams}{diagrams-contrib}
\end{subsection}
\end{section}


\begin{section}{Honours and Awards}
\dateauthor{2015}{Yelp}{SoftEng Capstone Design Symposium (2nd place)}
\end{section}

<p>&nbsp;</p>

