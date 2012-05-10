#!/usr/local/bin/macruby

# framework "Cocoa"
framework "ScriptingBridge"

omnifocus = SBApplication.applicationWithBundleIdentifier("com.omnigroup.OmniFocus")

exit unless omnifocus.isRunning

document = omnifocus.defaultDocument

puts "You have #{document.flattenedTasks.size} tasks."
