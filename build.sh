
MAINFILES="thesis summary"
FINALDIR=`pwd`

#Cannot use TMPDIR variable, it is reserved
TMPLOCAL=`mktemp -d` || errorleave "Could not create temporary directory"

cleanup(){
	[ -d "${TMPLOCAL}" ] && rm -rf "${TMPLOCAL}"
}

errorleave(){
	echo "Error:"
	echo " ${1}"
	cleanup
	exit 1
}

pdfing(){
	pdflatex ${1}.tex
	makeindex ${1}
	bibtex ${1}
	pdflatex ${1}.tex
	pdflatex ${1}.tex && cp ${1}.pdf ${FINALDIR}/bin/
}

main(){
	cp -R src/* "${TMPLOCAL}"
	cd "${TMPLOCAL}"

	for i in ${MAINFILES}
	do
		pdfing ${i}
	done
}

#starts here
main

cleanup
