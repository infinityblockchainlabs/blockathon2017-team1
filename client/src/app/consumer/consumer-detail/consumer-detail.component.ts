import { Component, OnInit } from '@angular/core';
import { Home } from '../../models/home';

@Component({
  selector: 'app-consumer-detail',
  templateUrl: './consumer-detail.component.html',
  styleUrls: ['./consumer-detail.component.css']
})
export class ConsumerDetailComponent implements OnInit {
  public home = new Home();
  constructor() { }

  ngOnInit() {
  }
}
