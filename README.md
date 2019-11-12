# lpmiaw-terminal-agenda

lpmiaw-terminal-agenda est un petit programme permettant d'accéder très rapidement à l'emploi du temps de la LP MIAW de La Rochelle. 

Celui-ci a été développé en shell et a pour but d'avoir un aperçu visuel de son emploi du temps (jusqu'à une semaine) directement depuis son terminal. 

Son objectif est donc de simplifier la vie des étudiants, des professeurs, et des mordus d'interface terminal (comme moi) de la LP MIAW de La Rochelle afin de pouvoir directement consulter l'EDT depuis le terminal, le tout avec une petit interface de type ASCII art.

## Dépendances
- **wget**  
`sudo apt-get install wget` pour Linux (Debian/Ubuntu)  
`brew install wget` pour Mac (https://brew.sh/index_fr)  

## Comment l'installer
1.  `git clone https://github.com/XinTecK/terminal-edt-lpmiaw`
2.  `cd terminal-edt-lpmiaw`
3.  `./edt.sh`
4.  (facultatif => Création d'un lien symbolique pour pouvoir lancer l'edt juste en tapant `edt` n'importe où depuis son terminal) `sudo ln -s /mon/chemin/a/edt/edt.sh /usr/bin/edt`

Ce programme est développé en shell script et est à destination des systèmes d'explotations basés sur Unix (Linux pour sûr, Mac pas encore testé)

### Auteur
Hugo Lefrancq :  
[Site Web](https://hugolefrancq.fr)  
[Twitter](https://twitter.com/xinteck_)  
[LinkedIn](https://www.linkedin.com/in/hugo-lefrancq-b78ba5155/)

### Licence:
lpmiaw-terminal-agenda est sous la [licence GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), voir le fichier "LICENSE".

