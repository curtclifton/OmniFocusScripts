/*
 OmniFocus.h
 
 Generated with `sdef /Applications/OmniFocus.app | sdp -fh --basename OmniFocus`

 OmniFocusProject is generated with duplicate container properties. Need to delete one.
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>


@class OmniFocusApplication, OmniFocusDocument, OmniFocusWindow, OmniFocusDocumentWindow, OmniFocusSetting, OmniFocusFocusSections, OmniFocusSection, OmniFocusFolder, OmniFocusContext, OmniFocusProject, OmniFocusTask, OmniFocusAvailableTask, OmniFocusRemainingTask, OmniFocusInboxTask, OmniFocusFlattenedTask, OmniFocusFlattenedProject, OmniFocusFlattenedFolder, OmniFocusFlattenedContext, OmniFocusPerspective, OmniFocusPreference, OmniFocusTree, OmniFocusQuickEntryTree, OmniFocusSidebarTree, OmniFocusContentTree, OmniFocusInboxTree, OmniFocusLibraryTree, OmniFocusDescendantTree, OmniFocusAncestorTree, OmniFocusLeaf, OmniFocusFollowingSibling, OmniFocusPrecedingSibling, OmniFocusSelectedTree, OmniFocusStyle, OmniFocusAttribute, OmniFocusNamedStyle, OmniFocusRichText, OmniFocusCharacter, OmniFocusParagraph, OmniFocusWord, OmniFocusAttributeRun, OmniFocusAttachment, OmniFocusFileAttachment;

enum OmniFocusSaveOptions {
	OmniFocusSaveOptionsYes = 'yes ' /* Save the file. */,
	OmniFocusSaveOptionsNo = 'no  ' /* Do not save the file. */,
	OmniFocusSaveOptionsAsk = 'ask ' /* Ask the user whether or not to save the file. */
};
typedef enum OmniFocusSaveOptions OmniFocusSaveOptions;

enum OmniFocusPrintingErrorHandling {
	OmniFocusPrintingErrorHandlingStandard = 'lwst' /* Standard PostScript error handling */,
	OmniFocusPrintingErrorHandlingDetailed = 'lwdt' /* print a detailed report of PostScript errors */
};
typedef enum OmniFocusPrintingErrorHandling OmniFocusPrintingErrorHandling;

enum OmniFocusProjectStatus {
	OmniFocusProjectStatusActive = 'FCPa' /* Active */,
	OmniFocusProjectStatusOnHold = 'FCPh' /* On Hold */,
	OmniFocusProjectStatusDone = 'FCPd' /* Done */,
	OmniFocusProjectStatusDropped = 'FCPD' /* Dropped */
};
typedef enum OmniFocusProjectStatus OmniFocusProjectStatus;

enum OmniFocusIntervalUnit {
	OmniFocusIntervalUnitMinute = 'FCIM' /* Minutes */,
	OmniFocusIntervalUnitHour = 'FCIH' /* Hours */,
	OmniFocusIntervalUnitDay = 'FCId' /* Days */,
	OmniFocusIntervalUnitWeek = 'FCIw' /* Weeks */,
	OmniFocusIntervalUnitMonth = 'FCIm' /* Months */,
	OmniFocusIntervalUnitYear = 'FCIy' /* Years */
};
typedef enum OmniFocusIntervalUnit OmniFocusIntervalUnit;

enum OmniFocusRepetitionMethod {
	OmniFocusRepetitionMethodFixedRepetition = 'FRmF' /* Repeat on a fixed schedule. */,
	OmniFocusRepetitionMethodStartAfterCompletion = 'FRmS' /* Start again after completion. */,
	OmniFocusRepetitionMethodDueAfterCompletion = 'FRmD' /* Due again after completion. */
};
typedef enum OmniFocusRepetitionMethod OmniFocusRepetitionMethod;

enum OmniFocusLocationTrigger {
	OmniFocusLocationTriggerNotifyWhenArriving = 'Larv' /* notify when arriving at this location */,
	OmniFocusLocationTriggerNotifyWhenLeaving = 'Llev' /* notify when leaving this location */
};
typedef enum OmniFocusLocationTrigger OmniFocusLocationTrigger;



/*
 * Standard Suite
 */

// The application's top-level scripting object.
@interface OmniFocusApplication : SBApplication

- (SBElementArray *) perspectives;
- (SBElementArray *) preferences;
- (SBElementArray *) documents;
- (SBElementArray *) windows;

@property (copy, readonly) NSString *name;  // The name of the application.
@property (readonly) BOOL frontmost;  // Is this the frontmost (active) application?
@property (copy, readonly) NSString *version;  // The version of the application.
@property (copy, readonly) NSString *buildNumber;  // This is the build number of the application, for example 63.1 or 63.  Major and minor versions are separated by a dot.  So 63.10 comes after 63.1.
@property (copy) NSDate *referenceDate;  // The date on from which the date collated smart groups are based.  When set, the reference date will be rounded to the first instant of the day of the specified date.
@property (copy) OmniFocusDocument *defaultDocument;  // The user's default document.
@property (copy) OmniFocusQuickEntryTree *quickEntry;  // The Quick Entry panel for the default document.
@property (copy, readonly) NSArray *perspectiveNames;  // The names of all available perspectives.
@property (copy, readonly) NSArray *allowedMailSenders;  // The list of addresses allowed to send Mail to OmniFocus.

- (SBObject *) open:(id)x usingCache:(BOOL)usingCache repairInPlace:(BOOL)repairInPlace upgradeInPlace:(BOOL)upgradeInPlace;  // Open one or more documents.
- (void) GetURL:(NSString *)x;  // Open a document from an URL.
- (void) print:(id)x withProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) quitSaving:(OmniFocusSaveOptions)saving;  // Quit the application.
- (BOOL) exists:(id)x;  // Verify if an object exists.
- (NSArray *) complete:(NSString *)x as:(NSNumber *)as spanClass:(NSString *)spanClass maximumMatches:(NSInteger)maximumMatches;  // Generate a list of completions given a string.
- (NSArray *) parseTasksWithTransportText:(NSString *)withTransportText asSingleTask:(BOOL)asSingleTask;  // Converts a textual representation of tasks into tasks.
- (void) import:(NSURL *)x at:(SBObject *)at withContextsAt:(SBObject *)withContextsAt;  // Imports a file into an existing OmniFocus document.
- (void) add:(id)x to:(SBObject *)to;  // Add the given object(s) to the container.
- (void) remove:(id)x from:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) select:(id)x extending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopy:(id)x as:(id)as;  // Copies one or more nodes to the pasteboard.
- (void) pbpasteAt:(SBObject *)at;  // Pastes nodes from the pasteboard.
- (void) pbsaveIn:(NSURL *)in_ as:(NSString *)as;  // Saves data from the pasteboard to a file.
- (void) insert:(NSString *)x at:(SBObject *)at using:(OmniFocusStyle *)using_;  // Insert text in the middle of an existing blob of text.

@end

// An OmniFocus document.
@interface OmniFocusDocument : SBObject

- (SBElementArray *) settings;
- (SBElementArray *) documentWindows;
- (SBElementArray *) sections;
- (SBElementArray *) folders;
- (SBElementArray *) projects;
- (SBElementArray *) contexts;
- (SBElementArray *) inboxTasks;
- (SBElementArray *) tasks;
- (SBElementArray *) flattenedTasks;
- (SBElementArray *) flattenedProjects;
- (SBElementArray *) flattenedFolders;
- (SBElementArray *) flattenedContexts;

- (NSString *) id;  // The document's unique identifier.
@property (readonly) BOOL canUndo;  // Whether the document can undo the most recent command.
@property (readonly) BOOL canRedo;  // Whether the document can redo the most recently undone command.
@property BOOL willAutosave;  // Whether the document will autosave.
@property BOOL compressesTransactions;  // Whether the document will write compressed transactions to disk; defaults to true.
@property BOOL includesSummaries;  // Whether the document will write computed summary information when writing transactions.
@property (readonly) BOOL syncing;  // True if the document is currently syncing, false otherwise.
@property (copy, readonly) NSDate *lastSyncDate;  // Date of the last sync.
@property (copy, readonly) NSString *lastSyncError;  // Error message (if any) for the last sync.
@property (copy) OmniFocusQuickEntryTree *quickEntry;  // The Quick Entry panel for the document.
@property (copy, readonly) NSString *name;  // The document's name.
@property (readonly) BOOL modified;  // Has the document been modified since the last save?
@property (copy, readonly) NSURL *file;  // The document's location on disk.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// A window.
@interface OmniFocusWindow : SBObject

@property (copy, readonly) NSString *name;  // The full title of the window.
- (NSInteger) id;  // The unique identifier of the window.
@property NSInteger index;  // The index of the window, ordered front to back.
@property NSRect bounds;  // The bounding rectangle of the window.
@property (readonly) BOOL closeable;  // Whether the window has a close box.
@property (readonly) BOOL minimizable;  // Whether the window can be minimized.
@property BOOL minimized;  // Whether the window is currently minimized.
@property (readonly) BOOL resizable;  // Whether the window can be resized.
@property BOOL visible;  // Whether the window is currently visible.
@property (readonly) BOOL zoomable;  // Whether the window can be zoomed.
@property BOOL zoomed;  // Whether the window is currently zoomed.
@property (copy, readonly) OmniFocusDocument *document;  // The document whose contents are being displayed in the window.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end



/*
 * OmniFocus suite
 */

// A window of an OmniFocus document.
@interface OmniFocusDocumentWindow : OmniFocusWindow

@property (copy) NSString *searchTerm;  // The search term in the toolbar.  If there is no search toolbar item, this will return missing value instead of an empty string and setting it will cause an error.
@property (copy, readonly) OmniFocusSidebarTree *sidebar;  // The tree of objects in the window sidebar.
@property (copy, readonly) OmniFocusContentTree *content;  // The tree of objects in the main window content.
@property (copy, readonly) NSArray *availableViewModeIdentifiers;  // A list of strings identifying all the available view modes.
@property (copy) NSString *selectedViewModeIdentifier;  // The currently selected view mode.
@property (copy) NSString *perspectiveName;  // The name of a perspective.
@property (copy) id focus;  // A list of the projects and folders forming the project focus of this document window.


@end

// Document setting
@interface OmniFocusSetting : SBObject

- (NSString *) id;  // The identifier of the setting.
@property (copy) id value;  // The current value of the setting.
@property (copy) id defaultValue;  // The default value of the setting.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// The current focus of a document window.
@interface OmniFocusFocusSections : SBObject


- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// A portion of a folder or document; either a project or a folder.
@interface OmniFocusSection : SBObject

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// A group of projects and sub-folders representing an folder of responsibility.
@interface OmniFocusFolder : OmniFocusSection

- (SBElementArray *) sections;
- (SBElementArray *) folders;
- (SBElementArray *) projects;
- (SBElementArray *) flattenedProjects;
- (SBElementArray *) flattenedFolders;

- (NSString *) id;  // The identifier of the folder.
@property (copy) NSString *name;  // The name of the folder.
@property (copy) OmniFocusRichText *note;  // The note of the folder.
@property BOOL hidden;  // Set if the folder is currently hidden.
@property (readonly) BOOL effectivelyHidden;  // Set if the folder is currently hidden or any of its container folders are hidden.
@property (copy, readonly) NSDate *creationDate;  // When the folder was created.
@property (copy, readonly) NSDate *modificationDate;  // When the folder was last modified.
@property (copy, readonly) id container;  // The containing folder or document.
@property (copy, readonly) id containingDocument;  // The containing document or quick entry tree of the object.


@end

// A context.
@interface OmniFocusContext : SBObject

- (SBElementArray *) contexts;
- (SBElementArray *) flattenedContexts;
- (SBElementArray *) tasks;
- (SBElementArray *) availableTasks;
- (SBElementArray *) remainingTasks;

- (NSString *) id;  // The identifier of the context.
- (void) setId: (NSString *) id;
@property (copy) NSString *name;  // The name of the context.
@property (copy) OmniFocusRichText *note;  // The note of the context.
@property BOOL allowsNextAction;  // If false, tasks assigned to this context will be skipped when determining the next action for a project.
@property BOOL hidden;  // Set if the context is currently hidden.
@property (readonly) BOOL effectivelyHidden;  // Set if the context is currently hidden or any of its container contexts are hidden.
@property (copy, readonly) OmniFocusContext *container;  // The containing context.
@property (readonly) NSInteger availableTaskCount;  // A count of the number of unblocked and incomplete tasks of this context and all its active descendent contexts.
@property (readonly) NSInteger remainingTaskCount;  // A count of the number of incomplete tasks of this context and all its active descendent contexts.
@property (copy, readonly) id containingDocument;  // The containing document or quick entry tree of the object.
@property (copy) id location;  // The physical location of the context.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// A project.
@interface OmniFocusProject : OmniFocusSection

- (NSString *) id;  // The identifier of the project.
- (void) setId: (NSString *) id;
@property (copy, readonly) OmniFocusTask *rootTask;  // The root task of this project, holding the project's name, note, dates and child tasks.
@property (copy, readonly) id nextTask;  // The next actionable child of this project.
@property (copy) NSDate *lastReviewDate;  // When the project was last reviewed.
@property (copy) NSDate *nextReviewDate;  // When the project should next be reviewed.
@property (copy) NSDictionary *reviewInterval;  // The review interval for the project.
@property OmniFocusProjectStatus status;  // The status of the project.
@property BOOL singletonActionHolder;  // True if the project contains singleton actions.
@property BOOL defaultSingletonActionHolder;  // True if the project is the default holder of sington actions.  Only one project can have this flag set; setting it on a project will clear it on any other project having it.  Setting this to true will set 'singleton action holder' to true if not already so set.
@property (copy, readonly) id folder;  // The folder of the project, or missing value if it is contained directly by the document.
- (NSString *) id;  // The identifier of the project.
- (void) setId: (NSString *) id;
@property (copy) NSString *name;  // The name of the project.
@property (copy) OmniFocusRichText *note;  // The note of the project.
@property (copy, readonly) id container;  // The containing project, project or document.
@property (copy, readonly) id containingDocument;  // The containing document or quick entry tree of the object.
@property (copy) id context;  // The project's context.  If a child is added, this will be used for its context.
@property BOOL completedByChildren;  // If true, complete when children are completed.
@property BOOL sequential;  // If true, any children are sequentially dependent.
@property BOOL flagged;  // True if flagged
@property (readonly) BOOL blocked;  // True if the project has a project that must be completed prior to it being actionable.
@property (copy) NSDate *creationDate;  // When the project was created.  This can only be set when the object is still in the inserted state.  For objects created in the document, it can be passed with the creation properties.  For objects in a quick entry tree, it can be set until the quick entry panel is saved.
@property (copy, readonly) NSDate *modificationDate;  // When the project was last modified.
@property (copy) id startDate;  // When the project can be started.
@property (copy) id dueDate;  // When the project must be finished.
@property (copy) id completionDate;  // The project's date of completion.
@property BOOL completed;  // True if the project is completed.
@property (copy) id estimatedMinutes;  // The estimated time, in whole minutes, that this project will take to finish.
@property (copy) id repetitionRule;  // The repetition rule for this project, or missing value if it does not repeat.
@property (readonly) NSInteger numberOfTasks;  // The number of direct children of this project.
@property (readonly) NSInteger numberOfAvailableTasks;  // The number of available direct children of this project.
@property (readonly) NSInteger numberOfCompletedTasks;  // The number of completed direct children of this project.


@end

// An task.  This might represent the root of a project, an action within a project or other action or an inbox item.
@interface OmniFocusTask : SBObject

- (SBElementArray *) tasks;
- (SBElementArray *) flattenedTasks;

- (NSString *) id;  // The identifier of the task.
- (void) setId: (NSString *) id;
@property (copy) NSString *name;  // The name of the task.
@property (copy) OmniFocusRichText *note;  // The note of the task.
@property (copy, readonly) id container;  // The containing task, project or document.
@property (copy, readonly) id containingProject;  // The task's project, up however many levels of parent tasks.  Inbox tasks aren't considered contained by their provisionalliy assigned container, so if the task is actually an inbox task, this will be missing value.
@property (copy, readonly) id parentTask;  // The task holding this task.  If this is missing value, then this is a top level task -- either the root of a project or an inbox item.
@property (copy, readonly) id containingDocument;  // The containing document or quick entry tree of the object.
@property (readonly) BOOL inInbox;  // Returns true if the task itself is an inbox task or if the task is contained by an inbox task.
@property (copy) id context;  // The task's context.  If a child is added, this will be used for its context.
@property BOOL completedByChildren;  // If true, complete when children are completed.
@property BOOL sequential;  // If true, any children are sequentially dependent.
@property BOOL flagged;  // True if flagged
@property (readonly) BOOL next;  // If the task is the next task of its containing project, next is true.
@property (readonly) BOOL blocked;  // True if the task has a task that must be completed prior to it being actionable.
@property (copy) NSDate *creationDate;  // When the task was created.  This can only be set when the object is still in the inserted state.  For objects created in the document, it can be passed with the creation properties.  For objects in a quick entry tree, it can be set until the quick entry panel is saved.
@property (copy, readonly) NSDate *modificationDate;  // When the task was last modified.
@property (copy) id startDate;  // When the task can be started.
@property (copy) id dueDate;  // When the task must be finished.
@property (copy) id completionDate;  // The task's date of completion.
@property BOOL completed;  // True if the task is completed.
@property (copy) id estimatedMinutes;  // The estimated time, in whole minutes, that this task will take to finish.
@property (copy) id repetitionRule;  // The repetition rule for this task, or missing value if it does not repeat.
@property (readonly) NSInteger numberOfTasks;  // The number of direct children of this task.
@property (readonly) NSInteger numberOfAvailableTasks;  // The number of available direct children of this task.
@property (readonly) NSInteger numberOfCompletedTasks;  // The number of completed direct children of this task.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// A task that is available for action.  This is simply a filter on the existing tasks and should be considred a read-only element.  These cannot be created directly; instead create a normal task.
@interface OmniFocusAvailableTask : OmniFocusTask


@end

// A task that is not complete, though it may be blocked.  This is simply a filter on the existing tasks and should be considred a read-only element.  These cannot be created directly; instead create a normal task.
@interface OmniFocusRemainingTask : OmniFocusTask


@end

// A task that is in the document's inbox
@interface OmniFocusInboxTask : OmniFocusTask

@property (copy) id assignedContainer;  // Inbox tasks (those contained directly by the document) have a provisionally set container that is made final by the 'compact' command.  This allows you to set and get said container.  The container must be either a task (not in the inbox or contained by an inbox task), a project or 'missing value'.


@end

// A flattened list of tasks under a task or document.
@interface OmniFocusFlattenedTask : OmniFocusTask


@end

// A flattened list of projects under a folder or document.
@interface OmniFocusFlattenedProject : OmniFocusProject


@end

// A flattened list of folders in a document.
@interface OmniFocusFlattenedFolder : OmniFocusFolder


@end

// A flattened list of contexts in a document.
@interface OmniFocusFlattenedContext : OmniFocusContext


@end

// A perspective.
@interface OmniFocusPerspective : SBObject

- (NSString *) id;  // The identifier of the perspective.
- (void) setId: (NSString *) id;
@property (copy) NSString *name;  // The name of the perspective.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end



/*
 * OmniFoundation Scripting
 */

// Application preference
@interface OmniFocusPreference : SBObject

- (NSString *) id;  // The identifier of the preference.
@property (copy) id value;  // The current value of the preference.
@property (copy) id defaultValue;  // The default value of the preference.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end



/*
 * Omni Tree Suite
 */

// A tree representing an object, along with its sub-trees.
@interface OmniFocusTree : SBObject

- (SBElementArray *) trees;
- (SBElementArray *) descendantTrees;
- (SBElementArray *) ancestorTrees;
- (SBElementArray *) leaves;
- (SBElementArray *) precedingSiblings;
- (SBElementArray *) followingSiblings;
- (SBElementArray *) selectedTrees;

@property (copy, readonly) NSString *name;  // The name of the object being represented by this tree.
- (NSString *) id;  // The identifier of object being represented by this tree.
@property (copy, readonly) id value;  // The object being represented by this tree.
@property BOOL selected;  // This is true if the node is selected.  Note that attempts to set this while the node is not visible (collapsed parent, etc.) will silently do nothing.
@property BOOL expanded;  // This is true if the node is expanded.
@property BOOL noteExpanded;  // This is true if the node note is expanded.
@property (copy) NSArray *writablePasteboardTypes;  // A list of the types that can be used when writing nodes to the pasteboard (i.e., copying).
@property (copy) NSArray *readablePasteboardTypes;  // A list of the types that can be used when reading nodes from the pasteboard (i.e., pasteing).

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end



/*
 * OmniFocus suite
 */

// The Quick Entry panel.
@interface OmniFocusQuickEntryTree : OmniFocusTree

- (SBElementArray *) folders;
- (SBElementArray *) projects;
- (SBElementArray *) contexts;
- (SBElementArray *) inboxTasks;

@property (readonly) BOOL visible;  // Whether the quick entry panel is currently visible.


@end

// The tree of objects in the window sidebar.
@interface OmniFocusSidebarTree : OmniFocusTree

@property (copy, readonly) NSArray *availableSmartGroupIdentifiers;  // The list of possible smart group identifiers that can be set as the selected smart group identifier.
@property (copy) NSString *selectedSmartGroupIdentifier;  // The currently selected smart group identifier.
@property (copy) OmniFocusLibraryTree *library;
@property (copy) OmniFocusInboxTree *inbox;


@end

// The tree of objects in the main window content.
@interface OmniFocusContentTree : OmniFocusTree

@property (copy, readonly) NSArray *availableGroupingIdentifiers;  // The list of possible identifiers that can be set as the selected grouping identifier.
@property (copy) NSString *selectedGroupingIdentifier;  // The currently selected grouping identifier, controlling how the results shown in the content area are grouped.
@property (copy, readonly) NSArray *availableSortingIdentifiers;  // The list of possible identifiers that can be set as the selected sorting identifier.
@property (copy) NSString *selectedSortingIdentifier;  // The currently selected sorting identifier, controlling how the results shown in the content area are ordered.
@property (copy, readonly) NSArray *availableTaskStateFilterIdentifiers;  // The list of possible identifiers that can be set as the selected task state filter identifier.
@property (copy) NSString *selectedTaskStateFilterIdentifier;  // The currently selected task state filter identifier.
@property (copy, readonly) NSArray *availableTaskDurationFilterIdentifiers;  // The list of possible identifiers that can be set as the selected task duration filter identifier.
@property (copy) NSString *selectedTaskDurationFilterIdentifier;  // The currently selected task duration filter identifier.
@property (copy, readonly) NSArray *availableTaskFlaggedFilterIdentifiers;  // The list of possible identifiers that can be set as the selected task flagged filter identifier.
@property (copy) NSString *selectedTaskFlaggedFilterIdentifier;  // The currently selected task flagged filter identifier.


@end

// The tree in the sidebar representing the Inbox.
@interface OmniFocusInboxTree : OmniFocusTree


@end

// The tree in the sidebar representing the top level library of objects.
@interface OmniFocusLibraryTree : OmniFocusTree


@end



/*
 * Omni Tree Suite
 */

// All the descendant trees in the user-specified sort ordering, listing each tree, then its children and so forth.
@interface OmniFocusDescendantTree : OmniFocusTree


@end

// The ancestor trees of this tree.
@interface OmniFocusAncestorTree : OmniFocusTree


@end

// The descendants of a tree that have no children themselves.
@interface OmniFocusLeaf : OmniFocusTree


@end

// The sibling trees of this tree after it in the user-specified sort ordering.
@interface OmniFocusFollowingSibling : OmniFocusTree


@end

// The sibling trees of this tree before it in the user-specified sort ordering.
@interface OmniFocusPrecedingSibling : OmniFocusTree


@end

// The trees of this tree that are selected in the user interface, possibly including this tree.
@interface OmniFocusSelectedTree : OmniFocusTree


@end



/*
 * OmniStyle Scripting
 */

// A style object.
@interface OmniFocusStyle : SBObject

- (SBElementArray *) namedStyles;
- (SBElementArray *) attributes;

@property (copy, readonly) id container;  // The object owning the style.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// An attribute of a style.
@interface OmniFocusAttribute : SBObject

@property (copy, readonly) NSString *name;  // The name of the attribute.
@property (copy) OmniFocusStyle *style;  // The style to which the attribute refers.
@property (copy, readonly) OmniFocusStyle *definingStyle;  // The style responsible for the effective value in this attributes's style.  This processes the local values, inherited styles and cascade chain.
@property (copy) id value;  // The value of the attribute in its style.
@property (copy) id defaultValue;  // The default value of the attribute in its style.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// A named style object.
@interface OmniFocusNamedStyle : OmniFocusStyle

- (NSString *) id;  // An identifier for the named style that is unique within its document.  Currently this identifier is not persistent between two different sessions of editing the document.
@property (copy) NSString *name;  // The name of the style.  Must be unique within the containing document.


@end



/*
 * Text Suite
 */

// Rich (styled) text
@interface OmniFocusRichText : SBObject

- (SBElementArray *) characters;
- (SBElementArray *) paragraphs;
- (SBElementArray *) words;
- (SBElementArray *) attributeRuns;
- (SBElementArray *) attachments;
- (SBElementArray *) fileAttachments;

@property (copy) NSDictionary *color;  // The color of the first character.
@property (copy) NSString *font;  // The name of the font of the first character.
@property NSInteger size;  // The size in points of the first character.
@property (copy) OmniFocusStyle *style;  // The style of the text.

- (void) closeSaving:(OmniFocusSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(NSString *)as compression:(BOOL)compression;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (id) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy object(s) and put the copies at a new location.
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location.
- (SBObject *) archiveIn:(NSURL *)in_ compression:(BOOL)compression summaries:(BOOL)summaries usingCache:(BOOL)usingCache;  // Write an backup archive of the document.
- (void) compact;  // Hides completed tasks and processes any inbox items that have the necessary information into projects and tasks.
- (void) undo;  // Undo the last command.
- (void) redo;  // Redo the last undone command.
- (void) ical_synchronize;  // Synchronizes with iCal.
- (void) synchronize;  // Synchronizes with the shared OmniFocus sync database.
- (void) addTo:(SBObject *)to;  // Add the given object(s) to the container.
- (void) removeFrom:(SBObject *)from;  // Remove the given object(s) from the container.
- (void) selectExtending:(BOOL)extending;  // Select one or more objects.
- (void) pbcopyAs:(id)as;  // Copies one or more nodes to the pasteboard.

@end

// This subdivides the text into characters.
@interface OmniFocusCharacter : OmniFocusRichText


@end

// This subdivides the text into paragraphs.
@interface OmniFocusParagraph : OmniFocusRichText


@end

// This subdivides the text into words.
@interface OmniFocusWord : OmniFocusRichText


@end

// This subdivides the text into chunks that all have the same attributes.
@interface OmniFocusAttributeRun : OmniFocusRichText


@end

// Represents an inline text attachment.
@interface OmniFocusAttachment : OmniFocusRichText


@end

// A text attachment refering to a plain file.
@interface OmniFocusFileAttachment : OmniFocusAttachment

@property (copy, readonly) NSURL *fileName;  // The path to the file for the attachment, if the attachment resides outside the document.
@property (readonly) BOOL embedded;  // If true, the attachment data resides inside the document.  You can access the data by saving it to the disk.


@end

