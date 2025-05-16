#!/bin/bash

cd packages/core

flutter pub get

dart run build_runner build -d