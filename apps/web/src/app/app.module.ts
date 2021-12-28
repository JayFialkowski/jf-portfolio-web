import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import {HeaderModule} from '@web-portfolio/ui';

@NgModule({
  declarations: [AppComponent],
  imports: [BrowserModule, HeaderModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
