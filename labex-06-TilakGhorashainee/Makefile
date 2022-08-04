PROJECT_NAME		:= CrosswalkSearch
MIN_INSERTIONS		:= 10
MIN_COMMITS			:= 4
COMMITS				:= $(shell git rev-list --count HEAD)
FIRST_COMMIT_REV	:= $(shell git rev-list --max-parents=0 HEAD)
LAST_COMMIT_REV		:= $(shell git rev-list HEAD | head -n1)
INSERTIONS			:= $(shell git diff $(FIRST_COMMIT_REV) $(LAST_COMMIT_REV) --shortstat | sed -E 's/.* ([0-9]+) insertion.*/\1/')


.PHONY: verify_implementation made_changes sufficient_changes test stylecheck

made_changes:
	@ if [ $(COMMITS) -lt $(MIN_COMMITS) ] ; then \
		echo "No changes commited."; \
		exit 1; \
	fi

sufficient_changes:
	@ if [ $(INSERTIONS) -lt $(MIN_INSERTIONS) ] ; then \
		echo "Implementation does not seem to solve the problem."; \
		exit 1; \
	fi

verify_implementation: made_changes sufficient_changes
		@echo "Implemented a solution to the problem"

stylecheck: verify_implementation
	@swiftformat --lint --swiftversion 5.6 --disable trailingSpace .	

test: verify_implementation
	  xcodebuild test -project $(PROJECT_NAME).xcodeproj -scheme $(PROJECT_NAME) -sdk iphonesimulator -destination 'name=iPhone 12,OS=15.5'	 
